# Installs the puppetmaster.
class profile::puppetmaster{
  class{'::puppet::master':
    ensure               => installed,
    report_handlers      => ['http','puppetdb'],
    reporturl            => "http://${::puppet_master_host}/reports/upload",
    storeconfigs_backend => 'puppetdb',
    regenerate_certs     => true,
    basemodulepaths      => ['$confdir/modules','$confdir/library'],
    environmentpath      => '$confdir/environments',
    default_manifest     => '$confdir/manifests',
    autosign             => '/etc/puppet/autosign.conf',
    autosign_conf_path   => '/etc/puppet/autosign.conf',
    require              => [
      Class[
        'apache::mod::passenger',
        'ruby::dev'
      ]
    ],
  }

  exec{'puppetdb_ssl_setup':
    command => 'puppetdb ssl-setup',
    path    => ['/usr/sbin','/usr/bin','/bin'],
    creates => '/etc/puppetdb/ssl/private.pem',
    require => Class['puppet::master','puppetdb::master::config'],
    notify  => Service['puppetdb','httpd']
  }

  puppet::auth::header{'dashboard':
    order   => 'D',
    content => 'the D block holds ACL declarations for the Puppet Dashboard'
  }

  puppet::auth{'pm_dashboard_access_facts':
    order       => 'D100',
    path        => '/facts',
    description => 'allow the puppet dashboard server access to facts',
    auth        => 'yes',
    allows      => ['puppet.local','dashboard'],
    methods     => ['find','search'],
  }

  file {'/puppet':
    ensure => 'directory',
  }

  file {'/puppet/private':
    ensure => 'directory',
  }

  puppet::fileserver{'private':
    path        => '/private/%H',
    description => 'a private file share containing node specific files',
    require     => File['/puppet/private'],
  }

  puppet::auth{'private_fileserver':
    order       => 'A550',
    description => 'allow authenticated nodes access to the private file share',
    path        => '/puppet/private',
    allows      => '*',
  }

  file {'/puppet/public':
    ensure => 'directory',
  }

  puppet::fileserver{'public':
    path        => '/public',
    description => 'a public file share containing node specific files',
    require     => File['/puppet/public'],
  }

  puppet::auth{'public_fileserver':
    order       => 'A560',
    description => 'allow authenticated nodes access to the public file share',
    path        => '/puppet/public',
    allows      => '*',
  }

  puppet::autosign{'*.local': }
}