# This profile defines the ruby configuration profile for the
# puppet agent
class profile::ruby::puppet {
  # Install Ruby from brightbox
  include repository::ruby
  class{'ruby':
    version         => '1.9.1',
    switch          => true,
    latest_release  => true,
    require         => Class['repository::ruby'],
  }
  include ruby::dev
}