# Installs the puppet dashboard applicaiton
class profile::puppetdashboard {
  package{'libpq-dev': ensure => 'installed'}
  package{'libsqlite3-dev': ensure => 'installed'}
  package{'libxml2-dev': ensure => 'installed'}
  package{'libxslt1-dev': ensure => 'installed'}
  class { '::puppetdashboard':
    provider                          => 'git',
    legacy_report_upload_url          => false,
    db_host                           => 'puppet.local',
    db_adapter                        => 'postgresql',
    # ToDo: Replace this token!
    secret_token                      => '1088f6270d11a08fddfeb863fac0c23122efa8248789950ca3f73db64b4152036a2fae8fb4bc9683d3a859eac39ec7200227f203ada7df64a9a43b19e7cfc313',
    require                           => [
      Package[
        'ruby',
        'passenger-common1.9.1',
        'libpq-dev',
        'libsqlite3-dev',
        'libxml2-dev',
        'libxslt1-dev',
        'rake',
        'ruby-bundler',
        'nodejs'
      ],
    ]
  }
}