# Sets up apache with passenger to run a puppetmaster
class profile::apache::puppetmaster {
  class { 'apache':
    default_vhost => false,
  }
  class { 'apache::mod::passenger':
    passenger_high_performance    => 'on',
    passenger_max_pool_size       => 12,
    passenger_pool_idle_time      => 1500,
    # passenger_max_requests        => 1000,
    passenger_stat_throttle_rate  => 120,
    rack_autodetect               => 'off',
    rails_autodetect              => 'off',
    require                       => [Package['ruby'],Class['ruby::dev']],
  }
  package {'passenger-common1.9.1':
    ensure    => installed,
    require   => Class['apache::mod::passenger'],
  }
}
