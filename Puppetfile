# This Puppetfile was distributed with Dynaguppy
# https://github.com/Aethylred/dynaguppy
forge 'https://forgeapi.puppetlabs.com'

# The puppetlabs-stdlib has a compatibilty matrix
# https://github.com/puppetlabs/puppetlabs-stdlib#compatibility
# So be sure the appropriate version is specified for the installed
# version of puppet
mod 'puppetlabs-stdlib', '4.3.2'
mod 'puppetlabs-apt', '1.6.0'
# mod 'puppetlabs-apache', '1.1.1'
mod 'puppetlabs-nodejs', '0.6.1'
mod 'puppetlabs-vcsrepo', '1.1.0'
mod 'puppetlabs-ruby', '0.3.0'
mod 'camptocamp-augeas', '0.3.2'
mod 'puppetlabs-mcollective', '2.0.0'
mod 'puppetlabs-puppetdb', '4.0.0'
mod 'puppetlabs-postgresql', '4.0.0'

# Require updated versions
mod 'puppetlabs-mysql',
  :git => 'https://github.com/puppetlabs/puppetlabs-mysql.git',
  :ref => 'origin/master'

mod 'puppetlabs-apache',
  :git => 'https://github.com/puppetlabs/puppetlabs-apache.git',
  :ref => 'origin/master'

# Aethylred's modules
mod 'Aethylred-puppet', '1.2.3'
mod 'Aethylred-puppetdashboard', '1.0.4'
mod 'Aethylred-git', '0.2.0'
mod 'Aethylred-gitlab', '0.4.1'
