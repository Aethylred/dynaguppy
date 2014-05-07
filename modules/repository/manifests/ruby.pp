# Set up the Brightbox Ruby NG PPA
class repository::ruby {
  case $::osfamily {
    Debian:{
      apt::ppa{ 'ppa:brightbox/ruby-ng': }
    }
    RedHat:{
      warning('No ruby repositores available for RedHat based OSs')
    }
    default:{
      warning("No ruby repositories configured for an OS based on ${::osfamily}")
    }
  }
}