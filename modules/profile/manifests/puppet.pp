# This role installs the puppet agent
class profile::puppet {
  class{'::puppet':
    ensure  => '3.3.1-1puppetlabs1',
    require => Package['ruby'],
  }
  include puppet::conf
  include puppet::hiera
}