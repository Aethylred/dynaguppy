# Dynaguppy

DYNAmic Git managed pUPPet, Yeah!

Dynaguppy](dynaguppy) is a self-deploying Puppet configuration that uses [Git](git) to manage Puppet Environments by mapping them to branches from a code repository.
[dynaguppy]:https://github.com/Aethylred/dynaguppy
[git]:http://git-scm.com/

# Vagrant

There is a [testing harness set up for dynaguppy](https://github.com/Aethylred/dynaguppy-harness) using [Vagrant](http://www.vagrantup.com/) to provisions virtual machines into [VirtualBox](https://www.virtualbox.org/). Vagrant and VirtualBox will need to be installed and configured for your development and testing environment.

# Installation

## Bootstrapping the Puppet Master

Dynaguppy was developed to install on an Ubuntu 14.04 LTS server and set it up as a Puppet Master, other distributions should work, but have not yet been tested.

1. Start with a fresh server install with network and hostname configured, and login as root.
1. Make sure that the hostname and fully qualified domain name are configured correctly.
1. Update all packages (restart if required):

    ```shell
    $ apt-get update
    $ apt-get upgrade
    ```

1. Install git:

    ```
    $ apt-get install git
    ```

1. Replace the default puppet configuration with Dynaguppy:

    ```
    $ cd /etc
    $ rm -rf puppet
    $ git clone --recursive https://github.com/Aethylred/dynaguppy.git puppet
    ```

1. Change to the puppet configuration directory

    ```
    cd /etc/puppet
    ```

1. Bootstrap the puppet repositories and installation (**Note:** use the bootstrap script appropriate for your OS):

    ```
    ./bootstrap/ubuntu.sh
    ```

1. If the bootstrap script failed install puppet manually (do not overwrite any files) version 3.6 or later is required:

    ```
    apt-get install puppet
    ```

1. Install librarian-puppet and update Ruby gems:

    ```
    $ apt-get install ruby-dev pkg-config libxml2-dev libxslt1-dev ruby-bundler
    $ gem install librarian-puppet
    $ gem update
    ```

1. Bootstrap the Puppet modules managed with librarian-puppet (**NOTE:** Dynaguppy has librarian-puppet install modules into `/etc/puppet/environments/production/library`):

    ```
    $ cd /etc/puppet/environments/production
    $ librarian-puppet install --clean --verbose
    ```

1. If librarian-puppet install fails, try using an update instead:

    ```
    $ librarian-puppet update --verbose
    ```

1. Edit the node manifest `/etc/puppet/manifests/dynaguppy/puppetmaster.pp` to match the Puppet Master's hostname. Verify that this name matches the output from `facter fqdn`
1. Initialise the Puppetmaster SSL environment (*NOTE:* run the command and exit with `^C` after a minute or two to allow SSL certificates to generate):

    ```
    $ puppet master --no-daemonize
    ```

1. Use puppet to bootstrap the puppetmaster service (this will take a while):

    ```
    $ puppet apply -t /etc/puppet/environments/production/manifests
    ```

1. Stop the puppet services and install the certificates for puppetdb:

    ```
    $ service apache2 stop
    $ service puppetb stop
    $ puppetdb ssl-setup -f
    ```

1. Use puppet reassert services and fix file ownership and permissions:

    ```
    $ puppet apply -t /etc/puppet/environments/production/manifests
    ```

1. Verify the puppetmaster is running and responds to requests (there may be changes):

    ```
    $ puppet agent -t
    ```

1. Use a browser to navigate to the puppetmaster server's web site and check that the puppet dashboard is running.

This section is complete and should result in the installation and configuration of a Puppet Master with a running Dashboard (on port 80) so that both services can access PuppetDB (web interface on port 8080), and that all these services are backed by an internal PostgreSQL database.

## Bootstrapping the Gitlab server

Dynaguppy was developed to install Gitlab on an Ubuntu 14.04 LTS server, other distributions should work, but have not yet been tested.

1. Start with a fresh server install with network and hostname configured, and login as root.
1. Make sure that the hostname and fully qualified domain name are configured correctly.
1. Install puppet:

    ```
    apt-get install puppet
    ```

1. The default domain `*.local` is set to autosign on the puppet server, if the Gitlab server's fqdn does not match this pattern then either the autosign configuration needs to be updated, or the Gitlab server needs to request and retrieve a certificate from the Puppet Master.
1. Provided that the correct `fqdn` for the Gitlab server has been set in the `/etc/puppet/environments/production/manifests/site.pp` the bootstrap installation should run with the puppet agent:

    ```
    $ puppet agent -t
    ```

There are a number of tasks in the Gitlab server's manifest that can time out or not run reliably on poor network connections. They will often resolve over a number of puppet run.

The Gitlab server should be up and running on HTTPS as the default web site.

# Role and Profile

As Dynaguppy uses `librarian-puppet` to manage modules, most of the module subdirectories are ignored by Git, the exceptions are the `role` and the `profile` subdirectories.

The use of roles and profiles in Dynaguppy is based on the [presentation and examples](https://github.com/hunner/roles_and_profiles) by [Hunter Haugen](https://github.com/hunner) at [PuppetConf 2013](http://puppetconf.com/), which is in turn was based on a [similar presentation](http://www.slideshare.net/PuppetLabs/roles-talk) given by Craig Dunn at [Puppet Camp Stockholm 2013](http://puppetlabs.com/community/puppet-camp#previous).

# Git Hook Scripts

The git hook scripts used in Dynaguppy are maintained on their own [githb repository](https://github.com/Aethylred/puppet-helpers) and are derived from these [puppet helper hook scripts](https://gitorious.org/puppet-helpers/puppet-helpers). These hook scripts have two parts.

## `update`

The `update` hook scripts process pushes to the Puppet manifest repository set up on the Gitlab server. The script rejects commits if:

* puppet files (`*.pp`) in the commit fails Puppet syntax validation
* Ruby files (`*.rb`) in the commit fails Ruby syntax validation
* ERB templates (`*.erb`) in the commit fails Ruby syntax validation

## `post-receive`

The `post-receive` script has the git user SSH on the Gitlab server SSH to the puppetmaster and update, create, or delete puppet environment directories that match the git branch that was pushed to the repository. Dynaguppy is sets these user accounts up so they have the appropriate SSH access to each other. The master branch is mapped to the production environment, so the production branch is reserved and is not pushed to the puppetmaster.

# Upgrading Ruby

Dynaguppy runs on Ruby version 1.8.7 as this is compatible across the range of Puppet versions that are available from the Linux distribution package repositories. Once Dynaguppy has bootstrapped Puppet to version 3.x it should be possible to upgrade to Ruby 1.9.3 or 2.x. Be sure to check the [Ruby compatibility guide](http://docs.puppetlabs.com/guides/platforms.html#ruby-versions) in the Puppet documentation

Ruby has poor heap management and inefficient garbage collection it is recommended that Ruby to be upgraded to 1.9.3 or later.

## Ruby, RVM vs. Package Managers

It would seem there is ongoing issues with Ruby being installed with the native package managers for some Linux distributions.

The Ruby community insist that Ruby and Ruby Gems should only be maintained with Ruby tools (such as [RVM](https://rvm.io/)) as Ruby development is rapid and Ruby developers know best to what Ruby versions and gems should be installed.

This is correct for a cutting-edge development environment.

The Linux distrubutors insist that software and applications are distributed through their respective package managers as they have been put through testing and QA systems to verify their integrity and compatibility with their Linux distribution.

This is correct for a stable and consistent operating system.

This situation has been intractible for this project, hence a neutral position will be taken. Ruby will be used as it is installed as a dependency of Puppet (as a package from the distribution package repository). The Ruby module included with Dynaguppy will only be used to configure the Ruby environment.

Do not be surprised if this changes through the development of Dynaguppy.

# Contributions

## Bootstrap scripts

The Puppet bootstrap scripts used in Dynaguppy are provided by the [Hashicorp](http://www.hashicorp.com/) [puppet bootstrap scripts](https://github.com/hashicorp/puppet-bootstrap) that are are recommended to bootstrap puppet for [Vagrant](http://www.vagrantup.com/).

# Attribution

This Puppet configration is derived from the [Dynaguppy](dynaguppy) project written by Aaron Hicks 2013.

# Licensing

This file is part of the dynaguppy project.

The dynaguppy is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

Foobar is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

A copy of the GNU General Public License is included with dynaguppy in the `gpl.txt` file.  If not, see <http://www.gnu.org/licenses/>.

<a rel="license" href="http://www.gnu.org/licenses/"><img alt="Gnu General Public Licence 3" style="border-width:0" src="http://www.gnu.org/graphics/gplv3-88x31.png" /></a>
