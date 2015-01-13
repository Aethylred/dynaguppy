# This is the Gitlab server
node 'git.local' {
  include defaults
  include defaults::python
  include defaults::ssh
  include role::gitlab

  Class['role::gitlab'] -> Class['dynaguppy::gitlab']

# The following statements set up the dynamic environments managed via git branching
  include dynaguppy::gitlab
  include dynaguppy::share_keys
}