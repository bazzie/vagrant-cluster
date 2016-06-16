class cluster::install inherits cluster::params {

  package {$cluster_packages:
    ensure  => 'installed',
  }


}
