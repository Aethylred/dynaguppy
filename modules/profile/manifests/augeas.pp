# This module ensures augeas is installed, with the appropriate libraries
class profile::augeas {
  class{'::augeas':
    ruby_version  => '1.9.1',
    before        => Class['profile::puppet'],
    require       => [Package['ruby']],
  }
}