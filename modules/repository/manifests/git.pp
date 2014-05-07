# Set up the Ubuntu Git Maintainers PPA
class repository::git {
  case $::osfamily {
    Debian:{
      apt::ppa{ 'ppa:git-core/ppa': }
    }
    RedHat:{
      warning('No git repositores available for RedHat based OSs')
    }
    default:{
      warning("No git repositories configured for an OS based on ${::osfamily}")
    }
  }
}