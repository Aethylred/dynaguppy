# This configures postgresql service for puppetdb and the puppetdashboard.
class profile::postgresql::puppetmaster {
  class { 'postgresql::server':
    ip_mask_allow_all_users => '0.0.0.0/0',
    listen_addresses        => $::puppet_master_host,
  }
}