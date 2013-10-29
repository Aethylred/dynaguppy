# This profile defines the ruby configuration profile for the
# puppet agent
class profile::ruby::puppet {
  # This installs the default ruby package
  # ...a repository with a later ruby version installed will
  # be required to get Ruby 1.9.3 or 2.x
  class{'ruby':
   # version => '1.8.7',
  }
}