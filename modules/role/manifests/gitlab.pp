# this class defines the gitlab role
class role::gitlab {
  # Explicitly defining ordering:
  Class[
    'profile::apache::gitlab'
  ] ->
  Class[
    'profile::gitlab'
  ]

  Class[
    'profile::postgresql::gitlab'
  ] ->
  Class[
    'profile::gitlab'
  ]

  # These profiles should be shared with all puppet clients

  include profile::git

  include profile::apache::gitlab
  include profile::postgresql::gitlab
  include profile::gitlab
}