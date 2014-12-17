# This is the puppet master manifest installed with
# Dynaguppy https://github.com/Aethylred/dynaguppy
node 'puppet.local' {
  class{'defaults':
    puppet => false,
  }
  include defaults::ssh
  include role::puppetmaster
  include dynaguppy::share_keys
}