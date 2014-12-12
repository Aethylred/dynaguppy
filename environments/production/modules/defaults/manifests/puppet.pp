# This class installs the default puppet agent
class defaults::puppet {
  class{'::puppet':
    ensure      => installed,
    agent       => 'running',
    server      => $::puppet_master_host,
    pluginsync  => true,
    report      => true,
    environment => $::environment,
    require     => [Package['ruby']],
  }
  include ::puppet::hiera
}