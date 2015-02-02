# This class creates the git repositories and injects the hook scripts
# that binds the puppet environments to git branches.
class dynaguppy::gitlab {

  gitlab::shell::repo{'puppet_manifest':
    group   => 'puppet',
    project => 'puppet',
  }

  gitlab::shell::repo{'hiera':
    group   => 'puppet',
    project => 'hiera',
  }

  $puppet_repository_uri = "git@${::gitlab_host}:puppet/puppet.git"
  $hiera_repository_uri  = "git@${::gitlab_host}:puppet/hiera.git"
  $puppetmaster_ssh_uri = "puppet@${::puppet_master_host}"

  gitlab::shell::repo::hook{'puppet_check_update':
    path   => 'update',
    target => 'puppet_manifest',
    source => 'puppet:///modules/dynaguppy/update',
  }

  $git_home = '/home/git'
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
    content => template('dynaguppy/checkers.py.erb'),
  }

  gitlab::shell::repo::hook{'puppet_check_git.py':
    path   => 'puppethooks/git.py',
    target => 'puppet_manifest',
    source => 'puppet:///modules/dynaguppy/puppethooks/git.py',
  }

  # This hook script pushes updates to the puppetmaster
  gitlab::shell::repo::hook{'post_receive_puppetmaster_push':
    path    => 'post-receive',
    target  => 'puppet_manifest',
    content => template('dynaguppy/post-receive.puppet.erb'),
  }

  # This hook script pushes updates to hiera data store
  gitlab::shell::repo::hook{'post_receive_hiera_push':
    path    => 'post-receive',
    target  => 'hiera',
    content => template('dynaguppy/post-receive.hiera.erb'),
  }
}