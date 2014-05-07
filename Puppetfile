# This Puppetfile was distributed with Dynaguppy
# https://github.com/Aethylred/dynaguppy
forge 'https://forge.puppetlabs.com'

# The puppetlabs-stdlib has a compatibilty matrix
# https://github.com/puppetlabs/puppetlabs-stdlib#compatibility
# So be sure the appropriate version is specified for the installed
# version of puppet
mod 'puppetlabs/stdlib', '4.1.0'
mod 'puppetlabs/apt', '1.3.0'
mod 'puppetlabs/apache', '1.0.1'
mod 'puppetlabs/mysql', '2.2.3'

# Other modules with updates
mod 'puppetlabs/ruby',
  :git => 'https://github.com/Aethylred/puppetlabs-ruby.git',
  :ref => 'versionfixes'

# Aethylred's modules
mod 'Aethylred/puppet',
  :git => 'https://github.com/nesi/puppet-puppet.git',
  :ref => '0.2.5'

mod 'Aethylred/puppetdashboard',
  :git => 'https://github.com/Aethylred/puppet-puppetdashboard.git',
  :ref => 'master'

mod 'Aethylred/git', '0.1.2'

mod 'camptocamp/augeas',
  :git => 'https://github.com/Aethylred/puppet-augeas.git',
  :ref => 'master'
