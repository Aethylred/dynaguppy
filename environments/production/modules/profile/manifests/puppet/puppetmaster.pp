# This installs puppet for a puppetmaster server
class profile::puppet::puppetmaster{
  class{'::puppet':
    ensure      => installed,
    agent       => 'running',
    user_shell  => '/bin/bash',
    server      => $::puppet_master_host,
    pluginsync  => true,
    report      => true,
    environment => $::environment,
    require     => [Package['ruby']],
  }
  include ::puppet::hiera
}