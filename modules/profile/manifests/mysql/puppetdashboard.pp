# Sets up mysql for the Puppet Dashboard application
class profile::mysql::puppetdashboard {
  class {'mysql::server':
    override_options => {
      'mysqld' => {
        'max_allowed_packet' => '32M',
      }
    },
  }
}