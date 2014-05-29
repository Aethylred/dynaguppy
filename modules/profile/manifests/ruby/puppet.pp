# This profile defines the ruby configuration profile for the puppet agent, puppetmaster and puppet-dashboard
class profile::ruby::puppet {
  # Install Ruby from brightbox
  include repository::ruby
  class{'ruby':
    version         => '1.9.1',
    switch          => true,
    latest_release  => true,
    require         => Class['repository::ruby'],
  }
  class {'ruby::dev':
    require => Class['ruby'],
  }
}