# A default git setup
# Note: it should be safe to use 'latest' for git.
# In stricter environments a specific version may be
# specified, but this will require managing per
# OS distribution and release version.
class profile::git {
  class { '::git':
    ensure => 'latest',
  }
  git::config{'push.default':
    provider => 'system',
    value    => 'matching'
  }
}
