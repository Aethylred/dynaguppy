# Dynaguppy

DYNAmic Git managed pUPPet, Yeah!

Dynaguppy](dynaguppy) is a self-deploying Puppet configuration that uses [Git](git) to manage Puppet Environments by mapping them to branches from a code repository.
[dynaguppy]:https://github.com/Aethylred/dynaguppy
[git]:http://git-scm.com/

# Vagrant

There is a [testing harness set up for dynaguppy](harness) using [Vagrant](vagrant) to provisions virtual machines into [VirtualBox](vbox). Vagrant and VirtualBox will need to be installed and configured for your development and testing environment.
[vagrant]:http://www.vagrantup.com/
[vbox]:https://www.virtualbox.org/
[harness]:https://github.com/Aethylred/dynaguppy-harness

# Installation

Dynaguppy was developed to install on an Ubuntu 12.04 LTS server and set it up as a Puppet Master, other distributions should work, but have not yet been tested.

1. Start with a fresh server install with network and hostname configured, and login as root.
1. Install puppet, any version after 2.6 is sufficient as Dynaguppy will upgrade to 3.3.2 by default:  
```
$ apt-get install puppet
```
1. Install git:  
```
$ apt-get install git
```
1. Install librarian-puppet:
```
$ gem install librarian-puppet
```
1. Replace the default puppet configuration with Dynaguppy:  
```
$ cd /etc
$ rm -rf puppet
$ git clone https://github.com/Aethylred/dynaguppy.git puppet
```
1. Bootstrap the Puppet modules managed with librarian-puppet:  
```
$ librarian-puppet install --clean
```
1. Edit the node manifest `/etc/puppet/manifests/dynaguppy/puppetmaster.pp` to match the Puppet Master's hostname.
1. ???
1. Profit


# Attribution

This Puppet configration is derived from the [Dynaguppy](dynaguppy) project written by Aaron Hicks 2013.

# Licensing

This file is part of the dynaguppy project.

The dynaguppy is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

Foobar is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

A copy of the GNU General Public License is included with dynaguppy in the `gpl.txt` file.  If not, see <http://www.gnu.org/licenses/>.

<a rel="license" href="http://www.gnu.org/licenses/"><img alt="Gnu General Public Licence 3" style="border-width:0" src="http://www.gnu.org/graphics/gplv3-88x31.png" /></a>
