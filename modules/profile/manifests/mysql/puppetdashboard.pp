# Sets up mysql for the Puppet Dashboard application
class profile::mysql::puppetdashboard {
  # Only the bindings are required if PostgreSQL is used.
  # class {'mysql::server':
  #   override_options => {
  #     'mysqld' => {
  #       'max_allowed_packet' => '32M',
  #     }
  #   },
  # }
  class {'mysql::bindings':
    ruby_enable               => true,
    ruby_package_ensure       => 'latest',
    client_dev                => true,
    client_dev_package_ensure => 'latest',
  }
}