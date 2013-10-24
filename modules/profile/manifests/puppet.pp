# This role installs the puppet agent
class profile::puppet {
  class{'::puppet':
    require => Package['ruby'],
  }
}