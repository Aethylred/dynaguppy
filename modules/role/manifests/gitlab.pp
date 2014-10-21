# this class defines the gitlab role
class role::gitlab {
  # Explicitly defining ordering:
  Class['profile::repositories'] ->
  Class[
    'profile::ruby::puppet'
  ] ->
  Class[
    'profile::librarian_puppet',
    'profile::puppet',
    'profile::apache::gitlab'
  ] ->
  Class[
    'profile::gitlab'
  ]

  Class['profile::repositories'] ->
  Class[
    'profile::ruby::puppet'
  ] ->
  Class[
    'profile::postgresql::gitlab'
  ] ->
  Class[
    'profile::gitlab'
  ]

  # These profiles should be shared with all puppet clients
  include profile::repositories

  include profile::git
  include profile::ruby::puppet
  include profile::librarian_puppet

  include profile::puppet

  include profile::apache::gitlab
  include profile::postgresql::gitlab
  include profile::gitlab
}