# Installs the puppet dashboard applicaiton
class profile::puppetdashboard {
  $dep_packages =[
    'openssl'
  ]

  package {$dep_packages: ensure => 'installed'}

  class { '::puppetdashboard':
    provider                 => 'git',
    legacy_report_upload_url => false,
    ca_server                => $::puppet_master_host,
    db_host                  => $::puppetdb_host,
    db_adapter               => 'postgresql',
    inventory_server         => $::puppetdb_host,
    file_bucket_server       => $::puppet_master_host,
    request_certs            => true,
    sign_certs               => true,
    # ToDo: Replace this token!
    secret_token             => '1088f6270d11a08fddfeb863fac0c23122efa8248789950ca3f73db64b4152036a2fae8fb4bc9683d3a859eac39ec7200227f203ada7df64a9a43b19e7cfc313',
    require                  => Package[$dep_packages]
  }
}