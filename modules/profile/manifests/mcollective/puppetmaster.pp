# Installs MCollecive on a puppet master
class profile::mcollective::puppetmaster {
  class { '::mcollective':
    middleware        => true,
    middleware_hosts  => ['puppet.local'],
  }
}