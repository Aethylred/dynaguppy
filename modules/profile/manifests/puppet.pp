# This role installs the puppet agent
class profile::puppet {
  class{'::puppet':
    ensure  => installed,
    require => Package['ruby'],
  }
  include ::puppet::conf
  include ::puppet::hiera
}