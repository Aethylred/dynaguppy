# This class installs the default puppet agent
class defaults::puppet {
  class{'::puppet':
    ensure        => installed,
    module_paths  => ['$confdir/library','$basemodulepath'],
    agent         => 'running',
    server        => $::puppet_master_host,
    pluginsync    => true,
    environment   => $::environment,
    require       => [Package['ruby']],
  }
  include ::puppet::hiera
}