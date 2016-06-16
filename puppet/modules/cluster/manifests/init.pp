class cluster inherits cluster::params {

  anchor { 'cluster::begin': } ->
  class { '::cluster::install': } ->
  class { '::cluster::config': } ~>
  class { '::cluster::service': } ->
  anchor { 'cluster::end': }


}
