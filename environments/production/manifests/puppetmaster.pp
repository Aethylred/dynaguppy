# This is the puppet master manifest installed with
# Dynaguppy https://github.com/Aethylred/dynaguppy
node 'puppet.local' {
  include defaults
  include role::puppetmaster
  include dynaguppy::share_keys
}