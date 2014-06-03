# This installs an embedded PuppetDB
class profile::puppetdb {
  class { '::puppetdb':
    database        => 'embedded',
    listen_address  => '0.0.0.0',
  }
  class { '::puppetdb::master::config':
    puppet_confdir          => '/etc/puppet',
    manage_storeconfigs     => false,
    manage_report_processor => false,
    strict_validation       => false,
    restart_puppet          => false,
  }
}