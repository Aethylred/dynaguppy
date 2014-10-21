class profile::gitlab {

  $dep_packages = ['libicu-dev','cmake']

  package{$dep_packages:
    ensure => 'present',
  }

  class{'::gitlab':
    gitlab_url  => "http://${::fqdn}/",
    require     => [
      Package[
        $dep_packages
      ]
    ]
  }
}