# This role installs the puppet agent
class profile::puppet {
  class{'::puppet':
    ensure        => installed,
    module_paths  => ['$confdir/library','$basemodulepath'],
    agent         => 'running',
    require       => [Package['ruby']],
  }
  include ::puppet::hiera
}