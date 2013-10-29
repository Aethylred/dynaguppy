class profile::repositories {
  case $::osfamily {
    Debian :{
      class{ 'apt':
        purge_sources_list_d  => true,
      }
      include repository::puppetlabs
      include repository::ruby
    }
    RedHat:{
      Yumrepo{
        stage => 'prep_repos',
      }
      include repository::puppetlabs
      include repository::ruby
    }
    default:{
      warning("There are no repositories configured for ${::osfamily}")
    }
  }
}