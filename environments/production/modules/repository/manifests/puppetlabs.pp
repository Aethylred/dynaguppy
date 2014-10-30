# This class sets up the Puppetlabs apt or yum repositories
class repository::puppetlabs {
  case $::osfamily {
    Debian:{
      apt::source { 'puppetlabs':
        location   => 'http://apt.puppetlabs.com',
        repos      => 'main',
        key        => '4BD6EC30',
        key_server => 'pgp.mit.edu',
      }
    }
    RedHat:{
      # Modified from https://github.com/stahnma/puppetlabs-puppetlabs_repo/blob/master/manifests/yum.pp
      $baseurl = 'http://yum.puppetlabs.com/'
      if $::operatingsystem == 'Fedora' {
        $ostype='fedora'
        $prefix='f'
      } else {
        $ostype='el'
        $prefix=''
      }

      yumrepo { 'puppetlabs-deps':
        baseurl  => "${baseurl}${ostype}/${prefix}\$releasever/dependencies/\$basearch",
        descr    => 'Puppet Labs Dependencies \$releasever - \$basearch ',
        enabled  => 1,
        gpgcheck => 1,
        gpgkey   => "${baseurl}RPM-GPG-KEY-puppetlabs",
      }

      yumrepo { 'puppetlabs-deps-source':
        baseurl  => "${baseurl}${ostype}/${prefix}\$releasever/dependencies/SRPMS",
        descr    => 'Puppet Labs Source Dependencies \$releasever - \$basearch - Source',
        enabled  => 0,
        gpgcheck => 1,
        gpgkey   => "${baseurl}RPM-GPG-KEY-puppetlabs",
      }

      yumrepo { 'puppetlabs-products':
        baseurl  => "${baseurl}${ostype}/${prefix}\$releasever/products/\$basearch",
        descr    => 'Puppet Labs Products \$releasever - \$basearch',
        enabled  => 1,
        gpgcheck => 1,
        gpgkey   => "${baseurl}RPM-GPG-KEY-puppetlabs",
      }

      yumrepo { 'puppetlabs-products-source':
        baseurl        => "${baseurl}${ostype}/${prefix}\$releasever/products/SRPMS",
        descr          => 'Puppet Labs Products \$releasever - \$basearch - Source',
        enabled        => 0,
        gpgcheck       => 1,
        gpgkey         => "${baseurl}RPM-GPG-KEY-puppetlabs",
      }

    }
    default:{
      fail("There is no Puppetlabs repository for ${::osfamily} based distributions.")
    }
  }
}