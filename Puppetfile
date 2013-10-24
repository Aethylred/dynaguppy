# This Puppetfile was distributed with Dynaguppy
# https://github.com/Aethylred/dynaguppy
forge "http://forge.puppetlabs.com"

# as puppet > 2.7.13 is required to get modules from the forge
# modules will be retrieved via git. The forge equivalents are 
# provided for convenience if/when puppet is upgraded.

# The puppetlabs-stdlib has compatibility a compatibilty matrix
# https://github.com/puppetlabs/puppetlabs-stdlib#compatibility
# So be sure the appropriate version is specified for the installed
# version of puppet
# stdlib module for Puppet 2.7.12 and earlier
mod 'stdlib',
  :git => 'https://github.com/puppetlabs/puppetlabs-stdlib.git',
  :ref => '2.5.1'
# stdlib module for Puppet 2.7.13 and later, up to 3.x
# mod 'puppetlabs/stdlib', '3.2.0'
# stdlib module for Puppet 3.x and later
# mod 'puppetlabs/stdlib', '4.1.0'

# puppetlabs-apt manages apt repositories
# apt module for Puppet 2.7.12 and earlier
mod 'apt',
  :git => 'https://github.com/puppetlabs/puppetlabs-apt.git',
  :ref => '1.4.0'
# apt module for Puppet 2.7.13 and later
# mod 'puppetlabs/apt', '1.3.0'

mod 'ruby',
  :git => 'https://github.com/Aethylred/puppetlabs-ruby.git'

mod 'puppet',
  :git => 'https://github.com/nesi/puppet-puppet.git',
  :ref => 'refactor'