# This profile defines the ruby configuration profile for the
# puppet agent
class profile::ruby::puppet {
  # Install Ruby 2.0 from brightbox
  # include repository::ruby
  class{'ruby':
   version  => '1.9.1',
   switch   => true,
   #require  => Class['repository::ruby'],
  }
  include ruby::dev
}