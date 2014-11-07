class profile::gitlab {

  $dep_packages = ['libicu-dev','cmake']

  package{$dep_packages:
    ensure => 'present',
  }

  class{'::gitlab':
    gitlab_url        => "http://${::gitlab_host}/",
    enable_https      => true,
    redirect_http     => true,
    gitlab_app_repo   => 'https://github.com/gitlabhq/gitlabhq.git',
    gitlab_app_rev    => '7-5-stable',
    gitlab_shell_repo => 'https://github.com/gitlabhq/gitlab-shell.git',
    gitlab_shell_rev  => 'v2.2.0',
    require           => [
      Package[
        $dep_packages
      ]
    ]
  }
}