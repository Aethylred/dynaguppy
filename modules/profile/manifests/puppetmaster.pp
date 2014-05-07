# Installs the puppetmaster.
class profile::puppetmaster{
  class{'::puppet::master':
    ensure          => installed,
    manifest        => '$confdir/manifests',
    report_handlers => 'http',
    reporturl       => 'http://localhost/reports/upload',
    require         => [
      Package['passenger-common1.9.1'],
      Class[
        'apache::mod::passenger',
        '::puppet::conf',
        'ruby::dev'
      ]
    ],
  }
}