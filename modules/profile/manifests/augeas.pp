# This module ensures augeas is installed, with the appropriate libraries
class profile::augeas {
  class{'::augeas':
    before        => Class['profile::puppet'],
    require       => [
      Package['ruby'],
      Class['repository::ruby']
    ],
  }
}