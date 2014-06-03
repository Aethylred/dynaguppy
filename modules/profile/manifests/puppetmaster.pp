# Installs the puppetmaster.
class profile::puppetmaster{
  class{'::puppet::master':
    ensure                => installed,
    manifest              => '$confdir/manifests',
    report_handlers       => ['http','puppetdb'],
    reporturl             => 'http://localhost/reports/upload',
    storeconfigs_backend  => 'puppetdb',
    require               => [
      Package['passenger-common1.9.1'],
      Class[
        'apache::mod::passenger',
        '::puppet::conf',
        'ruby::dev'
      ]
    ],
  }
}