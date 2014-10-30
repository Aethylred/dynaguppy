class profile::apache::gitlab {

  class{'apache':
    default_vhost => false,
    log_formats     => { common_forwarded => '%{X-Forwarded-For}i %l %u %t \"%r\" %>s %b'},
  }
  include apache::mod::passenger

}