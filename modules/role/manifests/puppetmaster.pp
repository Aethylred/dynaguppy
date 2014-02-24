# This class defines the puppetmaster role
class role::puppetmaster {
  # These profiles should be shared with all puppet clients
  include profile::repositories
  include profile::git
  include profile::ruby::puppet
  include profile::librarian_puppet
  include profile::puppet

  # These profiles are specific to a puppetmaster
  include profile::apache::puppetmaster
  include profile::puppetmaster
}