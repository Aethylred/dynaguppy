# This Puppetfile was distributed with Dynaguppy
# https://github.com/Aethylred/dynaguppy
forge "http://forge.puppetlabs.com"

# The puppetlabs-stdlib has compatibility a compatibilty matrix
# https://github.com/puppetlabs/puppetlabs-stdlib#compatibility
# So be sure the appropriate version is specified for the installed
# version of puppet
mod 'puppetlabs/stdlib', '4.1.0'

# puppetlabs-apt manages apt repositories
mod 'puppetlabs/apt', '1.3.0'

mod 'ruby',
  :git => 'https://github.com/Aethylred/puppetlabs-ruby.git'

mod 'puppet',
  :git => 'https://github.com/nesi/puppet-puppet.git',
  :ref => 'refactor'