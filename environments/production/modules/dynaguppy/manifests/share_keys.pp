# This class sets up SSH keys between specific user accounts.
class dynaguppy::share_keys {
  case $::fqdn {
    $::puppet_master_host: {
      # Only if run from a Puppetmaster
      if $::trusted and $::trusted['authenticated'] == 'remote' {
        keymaster::openssh::key{'git@gitlab': }
        keymaster::openssh::authorize{'git@gitlab':
          user    => 'puppet',
        }
      }
    }
    $::gitlab_host: {
      keymaster::openssh::deploy_pair{'git@gitlab':
        user => 'git',
      }
    }
    default: {
      warning("Dynaguppy has no keys to share for ${::fqdn}")
    }
  }
}