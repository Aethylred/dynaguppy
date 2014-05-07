# Installs the puppet dashboard applicaiton
class profile::puppetdashboard {
  class { '::puppetdashboard':
    servername  => '*',
    require     => [
      Class[
        'apache::mod::passenger',
        'profile::ruby::puppet',
        'profile::mysql::puppetdashboard',
        'ruby::dev'
      ],
      Package['ruby','passenger-common1.9.1'],
    ]
  }
}