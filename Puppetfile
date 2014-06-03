# This Puppetfile was distributed with Dynaguppy
# https://github.com/Aethylred/dynaguppy
forge 'https://forge.puppetlabs.com'

# The puppetlabs-stdlib has a compatibilty matrix
# https://github.com/puppetlabs/puppetlabs-stdlib#compatibility
# So be sure the appropriate version is specified for the installed
# version of puppet
mod 'puppetlabs/stdlib', '4.2.1'
mod 'puppetlabs/apt', '1.3.0'
mod 'puppetlabs/apache', '1.0.1'
mod 'puppetlabs/nodejs', '0.4.0'
mod 'puppetlabs/vcsrepo', '0.2.0'
mod 'puppetlabs/puppetdb', '3.0.1'

# Other modules with updates
mod 'puppetlabs/ruby',
  :git => 'https://github.com/Aethylred/puppetlabs-ruby.git',
  :ref => 'versionfixes'
mod 'puppetlabs/mysql',
  :git => 'https://github.com/Aethylred/puppetlabs-mysql.git',
  :ref => 'dev_libs'
mod 'camptocamp/augeas',
  :git => 'https://github.com/Aethylred/puppet-augeas.git',
  :ref => 'master'

# Aethylred's modules
mod 'Aethylred/puppet',
  :git => 'https://github.com/nesi/puppet-puppet.git',
  :ref => '0.2.6'

mod 'Aethylred/puppetdashboard', '0.2.2'
mod 'Aethylred/git', '0.1.2'
