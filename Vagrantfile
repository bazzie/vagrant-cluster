domain   = 'example.com'
data_disk = 'tmp/data.vdi'
docroot_data_disk = 'tmp/docroot_data.vdi'
q_disk = 'tmp/qdisk.vdi'

nodes = [
  { :hostname => 'node1',   :ip => '192.168.0.1', :box => 'nrel/CentOS-6.5-x86_64', :createdisks => true },
  { :hostname => 'node2',   :ip => '192.168.0.2', :box => 'nrel/CentOS-6.5-x86_64', :createdisks => false  },
  { :hostname => 'node3',   :ip => '192.168.0.3', :box => 'nrel/CentOS-6.5-x86_64', :createdisks => false  },
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = "nrel/CentOS-6.5-x86_64"
      nodeconfig.vm.hostname = node[:hostname] 
      nodeconfig.vm.network :private_network, ip: node[:ip]

      memory = node[:ram] ? node[:ram] : 256;
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.linked_clone = true
        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "50",
          "--memory", memory.to_s,
        ]
        if node[:createdisks] == true
	  unless File.exist?(data_disk)
            vb.customize ['createhd', '--filename', data_disk, '--size', 100, '--variant', 'fixed']
	  end
          unless File.exist?(docroot_data_disk)
            vb.customize ['createhd', '--filename', docroot_data_disk, '--size', 100, '--variant', 'fixed']
          end
          unless File.exist?(q_disk)
            vb.customize ['createhd', '--filename', q_disk, '--size', 100, '--variant', 'fixed']
          end
        end
        vb.customize ['modifyhd', data_disk, '--type', 'shareable']
        vb.customize ['modifyhd', docroot_data_disk, '--type', 'shareable']
        vb.customize ['modifyhd', q_disk, '--type', 'shareable']
        vb.customize ["storagectl", :id, "--name", "SCSIController", "--add", "scsi"]
        vb.customize ['storageattach', :id, '--storagectl', 'SCSIController', '--port', 0, '--device', 0, '--type', 'hdd', '--medium', data_disk]
        vb.customize ['storageattach', :id, '--storagectl', 'SCSIController', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', docroot_data_disk]
        vb.customize ['storageattach', :id, '--storagectl', 'SCSIController', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', q_disk]
      end
    end
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "site.pp"
    puppet.module_path = "puppet/modules"
    puppet.hiera_config_path = "hiera.yaml"
  end

end



