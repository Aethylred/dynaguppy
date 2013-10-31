# This class defines the puppetmaster role
class role::puppetmaster {
  include profile::repositories
  include profile::git
  include profile::ruby::puppet
  include profile::librarian_puppet
  include profile::puppet
}