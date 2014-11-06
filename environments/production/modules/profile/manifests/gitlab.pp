class profile::gitlab {

  $dep_packages = ['libicu-dev','cmake']

  package{$dep_packages:
    ensure => 'present',
  }

  class{'::gitlab':
    gitlab_url      => "http://${::gitlab_host}/",
    gitlab_app_repo => 'https://github.com/gitlabhq/gitlabhq.git',
    gitlab_app_rev  => 'v7.4.3',
    require         => [
      Package[
        $dep_packages
      ]
    ]
  }
}