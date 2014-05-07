# This class defines the puppetmaster role
class role::puppetmaster {
  # These profiles should be shared with all puppet clients
  include profile::repositories
  include profile::git
  include profile::ruby::puppet
  include profile::augeas
  include profile::librarian_puppet
  class{'profile::puppet':
    require => Class[profile::repositories],
  }

  # These profiles are specific to a puppetmaster
  include profile::apache::puppetmaster
  class{'profile::puppetmaster':
    require => Class[profile::repositories],
  }

  # These profiles are specific to running the Puppet Dashboard
  include profile::mysql::puppetdashboard
  class{'profile::puppetdashboard':
    require => Class[profile::repositories],
  }
}