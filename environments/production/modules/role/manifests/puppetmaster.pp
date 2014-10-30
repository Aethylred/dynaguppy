# This class defines the puppetmaster role
class role::puppetmaster {
  # Explicitly defining ordering:

  Class[
    'profile::librarian_puppet',
    'profile::apache::puppetmaster'
  ] ->
  Class[
    'profile::puppetdb'
  ] ->
  Class[
    'profile::puppetmaster',
    'profile::puppetdashboard'
  ]

  Class[
    'profile::mysql::puppetdashboard',
    'profile::postgresql::puppetmaster',
    'nodejs',
    'profile::git'
  ] ->
  Class[
    'profile::puppetdb'
  ] ->
  Class[
    'profile::puppetdashboard'
  ]

  include profile::git
  include profile::librarian_puppet

  # These profiles are specific to a puppetmaster
  include profile::postgresql::puppetmaster
  include profile::apache::puppetmaster
  include profile::puppetmaster

  # These profiles are specific to running a PuppetDB
  include profile::puppetdb

  # These profiles are specific to running the Puppet Dashboard
  include profile::mysql::puppetdashboard
  include nodejs
  include profile::puppetdashboard

}