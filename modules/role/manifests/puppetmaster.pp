# This class defines the puppetmaster role
class role::puppetmaster {
  # Explicitly defining ordering:
  Class['profile::repositories'] ->
  Class[
    'profile::ruby::puppet'
  ] ->
  Class[
    'profile::librarian_puppet',
    'profile::puppet',
    'profile::apache::puppetmaster'
  ] ->
  Class[
    'profile::puppetdb'
  ] ->
  Class[
    'profile::puppetmaster',
    'profile::puppetdashboard'
  ]

  Class['profile::repositories'] ->
  Class[
    'profile::ruby::puppet'
  ] ->
  Class[
    'profile::mysql::puppetdashboard',
    'profile::puppetdb',
    'nodejs',
    'profile::git'
  ] ->
  Class[
    'profile::puppetdashboard'
  ]

  # These profiles should be shared with all puppet clients
  include profile::repositories

  include profile::git
  include profile::ruby::puppet
  include profile::librarian_puppet

  include profile::puppet

  # These profiles are specific to a puppetmaster
  include profile::apache::puppetmaster
  include profile::puppetmaster

  # These profiles are specific to running a PuppetDB
  include profile::puppetdb

  # These profiles are specific to running the Puppet Dashboard
  include profile::mysql::puppetdashboard
  include nodejs
  include profile::puppetdashboard

}