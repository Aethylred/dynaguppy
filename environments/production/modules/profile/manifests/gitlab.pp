class profile::gitlab {

  $dep_packages = ['libicu-dev','cmake']

  package{$dep_packages:
    ensure => 'present',
  }

  class{'::gitlab':
    gitlab_url        => "http://${::gitlab_host}/",
    gitlab_app_repo   => 'https://github.com/gitlabhq/gitlabhq.git',
    gitlab_app_rev    => 'v7.4.3',
    gitlab_shell_repo => 'https://github.com/Aethylred/gitlab-shell.git',
    gitlab_shell_rev  => 'feature/custom_hooks',
    require           => [
      Package[
        $dep_packages
      ]
    ]
  }
}