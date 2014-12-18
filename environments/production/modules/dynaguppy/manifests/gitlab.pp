# This class creates the git repositories and injects the hook scripts
# that binds the puppet environments to git branches.
class dynaguppy::gitlab {

  gitlab::shell::repo{'puppet_manifest':
    group   => 'puppet',
    project => 'puppet',
  }

  $repository_uri = "https://${::gitlab_host}/puppet/puppet.git"
  $puppetmaster_ssh_uri = "puppet@${::puppet_master_host}"

  gitlab::shell::repo::hook{'puppet_check_update':
    path   => 'update',
    target => 'puppet_manifest',
    source => 'puppet:///modules/dynaguppy/update',
  }

  $puppethook_dir = "/home/git/repositories/puppet/puppet.git/custom_hooks/puppethooks"

  file{'puppethooks_dir':
    ensure => directory,
    path   => $puppethook_dir,
  }

  gitlab::shell::repo::hook{'puppet_check_init.py':
    path   => 'puppethooks/__init__.py',
    target => 'puppet_manifest',
    source => 'puppet:///modules/dynaguppy/puppethooks/__init__.py',
  }

  gitlab::shell::repo::hook{'puppet_check_checkers.py':
    path   => 'puppethooks/checkers.py',
    target => 'puppet_manifest',
    source => 'puppet:///modules/dynaguppy/puppethooks/checkers.py',
  }

  gitlab::shell::repo::hook{'puppet_check_git.py':
    path   => 'puppethooks/git.py',
    target => 'puppet_manifest',
    source => 'puppet:///modules/dynaguppy/puppethooks/git.py',
  }

  # This hook script pushes updates to the puppetmaster
  gitlab::shell::repo::hook{'post_receive_puppetmaster_push':
    path    => 'post_recieve',
    target  => 'puppet_manifest',
    content => template('dynaguppy/post_receive.erb'),
  }
}