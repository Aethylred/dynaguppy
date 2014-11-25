# This class creates the git repositories and injects the hook scripts
# that binds the puppet environments to git branches.
class dynaguppy::gitlab {

  gitlab::shell::repo{'puppet_manifest':
    group   => 'puppet',
    project => 'puppet',
  }
}