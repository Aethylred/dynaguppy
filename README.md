# Dynaguppy

DYNAmic Git managed pUPPet, Yeah!

Dynaguppy](dynaguppy) is a self-assembling Puppet framework that uses [Git](git) to manage Puppet Environments by mapping them to branches from a code repository that it also manages. There is more detail on how Dynaguppy is set up in the [internal documentation](environments/production/README.md).
[dynaguppy]:https://github.com/Aethylred/dynaguppy
[git]:http://git-scm.com/

# Vagrant

There is a [testing harness for dynaguppy](https://github.com/Aethylred/dynaguppy-harness) using [Vagrant](http://www.vagrantup.com/) to provisions virtual machines into [VirtualBox](https://www.virtualbox.org/). Vagrant and VirtualBox will need to be installed and configured for your development and testing environment. Cloning Dynaguppy into the `etc-puppet` directory should be sufficient.

# Installation

Installation of Dynaguppy is mostly automated, however it does require some manual steps. In time these manual interventions are expected to be reduced.

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

1. Bootstrap the puppet repositories and installation (use the bootstrap script appropriate for your OS, and set execute permission if required):

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

1. Bootstrap external Puppet modules managed with librarian-puppet (**NOTE:** Dynaguppy has librarian-puppet install external modules into `/etc/puppet/environments/production/library`):

    ```
    $ cd /etc/puppet/environments/production
    $ librarian-puppet install --clean --verbose
    ```

1. If librarian-puppet install fails, try using an update instead:

    ```
    $ librarian-puppet update --verbose
    ```

1. Edit the node manifest `/etc/puppet/manifests/dynaguppy/puppetmaster.pp` to match the Puppet Master's hostname. Verify that this name matches the output from `facter fqdn`
1. Edit the node manifest `/etc/puppet/manifests/dynaguppy/git.pp` to match the Gitlab Server's hostname. Verify that this name matches the output from `facter fqdn`
1. Edit the node manifest `/etc/puppet/manifests/site.pp` to match the Puppet Master and Gitlab server hostnames. Verify that this name matches the output from `facter fqdn`
1. Other files in the manifest may require changes. For example `/etc/puppet/environments/production/modules/profile/manifests/puppetmaster.pp` may require the `puppet::autosign` domain(s) changed. Please review the manifest.
1. Initialise the Puppetmaster SSL environment (**NOTE:** run the command and exit with `^C` after a minute or two to allow SSL certificates to generate):

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

1. Use puppet to restart the stopped services and fix file ownership and permissions:

    ```
    $ puppet apply -t /etc/puppet/environments/production/manifests
    ```

1. Make sure the Apache service is running:

    ```
    $ service apache2 status
    $ service apache2 start
    ```

1. Verify the puppetmaster is running and responds to requests (there may be changes):

    ```
    $ puppet agent -t
    ```

1. Some of the install components are sensitive to timing out or to network issues. It may take a couple of puppet agent runs to finish the install.
1. Use a browser to navigate to the puppetmaster server's web site and check that the puppet dashboard is running.

This section is complete and should result in the installation and configuration of a Puppet Master with a running [Puppet Dashboard](https://github.com/sodabrew/puppet-dashboard) (on port 80) so that both services can access PuppetDB (web interface on port 8080), and that all these services are backed by an internal PostgreSQL database.

## Bootstrapping the Gitlab server

Dynaguppy was developed to install Gitlab on an Ubuntu 14.04 LTS server, other distributions should work, but have not yet been tested.

1. Start with a fresh server install with network and hostname configured, and login as root.
1. Make sure that the hostname and fully qualified domain name are configured correctly.
1. Install puppet:

    ```
    apt-get install puppet
    ```

1. Edit `/etc/puppet/puppet.conf` and set the puppetmaster server to the puppet master. There should be the following block in the file:

    ```
    server=puppet.local
    ```

1. The default domain `*.local` is set to autosign on the puppet server, if the Gitlab server's fqdn does not match this pattern then either the autosign configuration needs to be updated, or the Gitlab server needs to request and retrieve a certificate from the Puppet Master.
1. Provided that the correct `fqdn` for the Gitlab server has been set in the `/etc/puppet/environments/production/manifests/site.pp` the bootstrap installation should run with the puppet agent:

    ```
    $ puppet agent --enable
    $ puppet agent -t
    ```

There are a number of tasks in the Gitlab server's manifest that time out or not run reliably on depending on the network connection. They will often resolve over a number of puppet run.

The Gitlab server should be up and running on HTTPS as the default web site.

## Git push to Puppetmaster configurations

### Set up the puppetmaster user on GitLab

The puppet manifests will have primed the puppetmaster and the gitlab site for integration, but some manual steps are required to complete this.

1. Locate the public ssh key for the `puppet` user on the puppetmaster, if the dynaguppy configuration has not changed it should be in `/var/lib/puppet/.ssh/id_rsa.pub`. The contents of this file will need to be copied and pasted in later steps.
1. Log into the Gitlab web application as the administrator user (the default is the `root` user with the password `5iveL!fe`), it will be necessary to change this default password before continuing.
1. Got to the Gitlab admin area
1. Click on the **New User** icon and create a new user named `puppetmaster`. Add whatever details are required.
1. Once the `puppetmaster` user has been created return to the admin area.
1. Select the `puppetmaster` user from the list of users.
1. Click on the **Edit** icon and use the administrator tools to set the `puppetmaster`user's password. Keep a record of this new password.
1. Go to the Gitlab admin area and select the `puppet` group.
1. Click the edit icon on the group members panel.
1. Add the sit `Administrator` and the `puppetmaster` user.
1. Set both users as **owner** of the `puppet` group.
1. Log out of the Gitlab application.
1. Log into the Gitlab application as the `puppetmaster` user, use the password set previously.
1. Go to the `puppetmaster` user's profile settings and add the puppetmaster's public key as a ssh key. This should allow the puppet user to push to and pull from the `puppet/puppet` project.
1. Check the Gitlab application dashboard, it should list the `puppet/puppet` project in the **Project** tab, click on it.
1. Take note of the ssh URI for the `puppet/puppet` project. It should be similar to `git@git.local:puppet/puppet.git` (this URI will be used as an example in these instructions, substitute it for the correct one)
1. Take note of the ssh URI for the `puppet/hiera` project. It should be similar to `git@git.local:puppet/hiera.git` (this URI will be used as an example in these instructions, substitute it for the correct one)

### Initial commit of the Puppet manifest
1. Log into the puppetmaster server as root
1. Clear the librarian-puppet cache with:

    ```
    # rm -rf /tmp/puppet-librarian
    ```

1. Change to the `production` environment directory:

    ```
    # cd /etc/puppet/environments/production
    ```

1. Check that all the contents belong to the puppet user.

    ```
    # chown -R puppet:puppet *
    ```

1. Change to the puppet user:

    ```
    # su -l puppet
    ```

1. Initialise with git, add all files and commit:

    ```
    # git init
    # git add -A
    # git commit -m 'Initial commit'
    ```

1. Verify access to Gitlab with ssh, it should respond with `Welcome to GitLab, Puppet Master!` and not `Welcome to GitLab, Anonymous!`:

    ```
    # ssh git@git.local
    ```

1. Add the Gitlab puppet repository as a remote:

    ```
    # git remote add origin git@git.local:puppet/puppet.git
    ```

1. Push to the repository

    ```
    # git push -u origin master
    ```


Dynaguppy should now have the puppetmaster directory environments synchronised with the puppet repository and it's branches on the Gitlab application.

It is recommended that the Puppetmaster user on Gitlabs has it's permissions reduced to **Reporter** once the Puppet manifest and Hiera data store have had their initial push. It is also recommended that another user other than the Administrator is made **Owner** of the `puppet/puppet` project.

**Note**: Git pushes to the `puppet/puppet` project may take some time, especially when changes have been made to the `Puppetfile` and trigger a librarian-puppet run. If other behaviour is required edit the [git hook script](environment/production/modules/dynaguppy/templates/post-receive.puppet.erb).

### Initial commit of the Hiera datastore
1. Log into the puppetmaster server as root

1. Change to the puppet user:

    ```
    # su -l puppet
    ```

1. Change to the hiera directory:

    ```
    # cd /etc/puppet/hiera
    ```

1. Check that all the contents belong to the puppet user.
1. Initialise with git, add all files and commit:

    ```
    # git init
    # git add -A
    # git commit -m 'Initial commit'
    ```

1. Verify access to Gitlab with ssh, it should respond with `Welcome to GitLab, Puppet Master!` and not `Welcome to GitLab, Anonymous!`:

    ```
    # ssh git@git.local
    ```

1. Add the Gitlab hiera repository as a remote:

    ```
    # git remote add origin git@git.local:puppet/hiera.git
    ```

1. Push to the repository

    ```
    # git push -u origin master
    ```


Dynaguppy should now have the puppetmaster Hiera datastore synchronised with the puppet repository.

It is recommended that the Puppetmaster user on Gitlabs has it's permissions reduced to **Reporter** once the Puppet manifest and Hiera data store have had their initial push. It is also recommended that another user other than the Administrator is made **Owner** of the `puppet/hiera` project.

**Note**: Git pushes to the master branch of the `puppet/hiera` project will be pushed to the Puppetmaster as a new Hiera configuration and datastore.

# Role and Profile

As Dynaguppy uses `librarian-puppet` to manage external Puppet modules and store them in the `library` directory and keep them from the internal modules stored in the `modules` directory. If other behaviour is required edit the [git hook script](environment/production/modules/dynaguppy/templates/post-receive.hiera.erb) and the [librarian-puppet configuration](.librarian/puppet/config).

The use of roles and profiles in the Dynaguppy Framework is based on the [presentation and examples](https://github.com/hunner/roles_and_profiles) by [Hunter Haugen](https://github.com/hunner) at [PuppetConf 2013](http://puppetconf.com/), which is in turn was based on a [similar presentation](http://www.slideshare.net/PuppetLabs/roles-talk) given by Craig Dunn at [Puppet Camp Stockholm 2013](http://puppetlabs.com/community/puppet-camp#previous).

# Git Hook Scripts

Dynaguppy has two sets of hook scripts that deploy the Puppet manifest and the Hiera data store to the Puppetmaster on a successful commit to the git repository.

## Puppet Manifest Hook Scripts

The Puppet Manifest git hook scripts used in Dynaguppy are maintained on their own [github repository](https://github.com/Aethylred/puppet-helpers) and are derived from these [puppet helper hook scripts](https://gitorious.org/puppet-helpers/puppet-helpers). These hook scripts have two parts.

## `update`

The `update` hook scripts process pushes to the Puppet manifest repository set up on the Gitlab server. The script rejects commits if:

* puppet files (`*.pp`) in the commit fails Puppet syntax validation
* Ruby files (`*.rb`) in the commit fails Ruby syntax validation
* ERB templates (`*.erb`) in the commit fails Ruby syntax validation

## `post-receive`

The `post-receive` script has the git user on the Gitlab server use SSH to access the puppetmaster and update, create, or delete puppet environment directories that match the git branch that was pushed to the repository. Dynaguppy is sets these user accounts up so they have the appropriate SSH access to each other. The master branch is mapped to the production environment, so the production branch is reserved and is not pushed to the puppetmaster. A sub-script `/usr/local/dynaguppy/bin/librarian-puppet-helper.sh` is also deployed to the Puppetmaster which is used to determine if `librarian-puppet` should be run, and under which conditions it should retry or fail.

## Hiera Manifest Hook Scripts

There is a single `post-receive` script used for Hiera deployment.

## `post-receive`

The `post-receive` script has the git user on the Gitlab server use SSH to access the puppetmaster and update the Hiera datastore. If the Hiera configuration file is altered, it also triggeres a reload of the Apache service to get the Puppetmaster to load the new Hiera configuration.

# Troubleshooting

## Trouble with the dashboard certificate on the Puppetmaster

If the first error in your puppet report is:

```
Error: Could not find certificate request for dashboard
```

This happens when the Puppet Dashboard tries to set itself up but the puppetmaster isn't listening for certificate requests. If your puppetmaster service is running on apache try:

```
$ rm /usr/share/puppet-dashboard/certs/dashboard.*.pem
$ puppet agent -t
```

# Upgrading Ruby

Dynaguppy can bootstrap from Ruby version 1.8.7 as this is compatible across the range of Puppet versions that are available from the Linux distribution package repositories. Once Dynaguppy has bootstrapped should have automatically upgraded to Ruby 2.0.0. Be sure to check the [Ruby compatibility guide](http://docs.puppetlabs.com/guides/platforms.html#ruby-versions) in the Puppet documentation.

Ruby 1.8.7 has poor heap management and inefficient garbage collection, so Dynaguppy enforces the recommended that Ruby to be upgraded to 1.9.3 or later.

## Ruby, RVM vs. Package Managers

It would seem there is ongoing issues with Ruby being installed with the native package managers for some Linux distributions.

The Ruby community insist that Ruby and Ruby Gems should be maintained with Ruby tools (such as [RVM](https://rvm.io/)) as Ruby development is rapid and Ruby developers know best to what Ruby versions and gems should be installed.

This is correct for a cutting-edge development environment.

The Linux distributors insist that software and applications are distributed through their respective package managers as they have been put through testing and QA systems to verify their integrity and compatibility with their Linux distribution.

This is correct for a stable and consistent operating system.

This situation has been difficult for this project, hence a [Ruby module](https://github.com/puppetlabs/puppetlabs-ruby) is included with Dynaguppy and is used to abstract these issues away.

# Contributions

## Bootstrap scripts

The Puppet bootstrap scripts used in Dynaguppy are provided by the [Hashicorp](http://www.hashicorp.com/) [puppet bootstrap scripts](https://github.com/hashicorp/puppet-bootstrap) that are are recommended to bootstrap puppet for [Vagrant](http://www.vagrantup.com/).

# Attribution

This Puppet configration is derived from the [Dynaguppy](dynaguppy) project written by Aaron Hicks 2013.

# Licensing

This file is part of the dynaguppy project.

Licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)
