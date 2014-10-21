# This installs an embedded PuppetDB
class profile::puppetdb {
  class { 'puppetdb::database::postgresql':
    listen_addresses => $::fqdn,
    manage_server    => false,
    # database_password => 'setthis!',
  }
  class { 'puppetdb::server':
    listen_address  => '0.0.0.0',
    database_host   => $::fqdn,
  }
  class { '::puppetdb::master::config':
    puppet_confdir          => '/etc/puppet',
    puppetdb_server         => 'puppet.local',
    manage_storeconfigs     => false,
    manage_report_processor => false,
    strict_validation       => false,
    restart_puppet          => false,
    notify                  => Service['httpd'],
    # read_database_passord => 'setthis!',
  }
}