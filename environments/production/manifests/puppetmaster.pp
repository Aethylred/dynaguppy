# This is the puppet master manifest installed with
# Dynaguppy https://github.com/Aethylred/dynaguppy
node 'puppet.local' {
  class{'defaults':
    puppet => false,
  }
  if $::trusted and $::trusted['authenticated'] == 'remote' {
    keymaster::host_key::key{'puppet.local':
      deploy => true,
    }
  }
  include defaults::ssh
  include role::puppetmaster
  include dynaguppy::share_keys
  include dynaguppy::puppetmaster
}