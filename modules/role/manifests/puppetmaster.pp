# This class defines the puppetmaster role
class role::puppetmaster {
  include profile::ruby::puppet
  include profile::librarian_puppet
  include profile::puppet
}