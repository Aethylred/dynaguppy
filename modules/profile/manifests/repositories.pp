class profile::repositories {
  case $::osfamily {
    Debian :{
      class{ 'apt':
        purge_sources_list_d  => true,
      }
      include repository::puppetlabs
    }
    RedHat:{
      Yumrepo{
        stage => 'prep_repos',
      }
      include repository::puppetlabs
    }
    default:{
      warning("There are no repositories configured for ${::osfamily}")
    }
  }
}