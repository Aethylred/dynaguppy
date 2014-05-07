# This class sets up the default suite of repositories
class profile::repositories {
  case $::osfamily {
    Debian :{
      class{ 'apt':
        purge_sources_list_d  => true,
        # stage                 => 'prep_repos',
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