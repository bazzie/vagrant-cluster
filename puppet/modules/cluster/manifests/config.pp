class cluster::config inherits cluster::params { 
  $params = [
   {
     name  => 'DUMMY',
     nodes => [
       {
         multicast       => '229.0.0.1',
         cic_fqdn        => 'dummy.cluster.platform.ot',
         cic_ip          => '1.2.3.4',
         fencing_methods => [
           {
             name     => 'first',
             device   => 'dummy',
             agent    => 'fence_dummy',
             address  => '2.3.4.5',
             user     => 'dummy@internal',
             password => 'kweenie',
           },
         ],
       },
     ],
   },
 ]


  file {'/etc/cluster/cluster.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template('cluster/cluster.conf.erb'),
  }




}
