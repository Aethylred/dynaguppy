# This role installs the puppet agent
class profile::puppet {
  class{'::puppet':
    ensure  => installed,
    require => [Package['ruby']],
  }
  class{'puppet::conf':
    module_path           => ['$confdir/library'],
    append_basemodulepath => true,
  }
  include ::puppet::hiera
}