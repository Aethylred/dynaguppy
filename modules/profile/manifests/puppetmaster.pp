# Installs the puppetmaster.
class profile::puppetmaster{
  class{'::puppet::master':
    ensure  => installed,
    require => [Class['::puppet::conf']],
  }
}