# This class installs the dynaguppy components on a puppetmaster.
# Mostly these are git helper scripts
class dynaguppy::puppetmaster{

  file{'/usr/local/dynaguppy':
    ensure => 'directory',
  }

  file{'/usr/local/dynaguppy/bin':
    ensure => 'directory',
  }

  file{'librarian-puppet-helper':
    ensure => 'file',
    path   => '/usr/local/dynaguppy/bin/librarian-puppet-helper.sh',
    mode   => '0755',
    source => 'puppet:///modules/dynaguppy/librarian-puppet-helper.sh',
  }
}