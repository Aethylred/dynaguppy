# Set up postgres for gitlab
class profile::postgresql::gitlab {
  include postgresql::server
  class {'postgresql::lib::devel':
    link_pg_config => false,
  }
}