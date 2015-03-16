# Dynaguppy Puppet Framework

This Puppet manifest is laid out according to the [Dynaguppy Puppet Framework](https://github.com/Aethylred/dynaguppy) and is intended to be used as a [Puppet directory environment](https://docs.puppetlabs.com/puppet/latest/reference/environments.html).

## Contents

In this manifest there will be the following:

* This `README.md` file.
* A `Puppetfile` for [`librarian-puppet`](http://librarian-puppet.com/) listing all the installed Puppet modules.
* A `.librarian` configuration directory for [`librarian-puppet`](http://librarian-puppet.com/).
* An [`environment.conf`](https://docs.puppetlabs.com/puppet/latest/reference/config_file_environment.html) file containing environment specific settings.
* A [`.gitignore`](http://git-scm.com/docs/gitignore) file as this directory is expected to be under change management with git.
* A `manifests` directory containing all the [Puppet node definitions](https://docs.puppetlabs.com/puppet/latest/reference/lang_node_definitions.html), one per file named by each node's fully qualified domain name.
* A [`modules` directory](https://docs.puppetlabs.com/puppet/latest/reference/dirs_modulepath.html) containing all the Puppet modules that are part of this manifest and are managed with it.

## Not Contents

In this manifest there should not be the following:

* A `library` folder, as this is generated in the environment directory on the Puppetmaster when `librarian-puppet` installs the modules specified in the `Puppetfile`. This folder will exist on the puppetmaster, but not in the content under git change management.

## Details

### Manifests

The manifests directory contains Puppet manifests for the entire site being managed ([`site.pp`](manifests/site.pp)) as well as the node definitions for all the nodes being managed by Puppet.

More detail on the layout of the `manifests` directory can be found in the [manifests README](manifests/README.md).

### Modules

The puppet modules in the Dynaguppy Framework a split into two categories: Internal and External.

#### External Modules

External Modules are the collection of Puppet modules that are independent and developed separately from the puppet manifest. These are managed with [`librarian-puppet`](http://librarian-puppet.com/) which requires them to be hosted on a git repository (like [GitHub](http://github.com) or [GitLab](https://about.gitlab.com/)) or a [Puppet Forge](https://forge.puppetlabs.com).

An external module must be specified in the `Puppetfile`, and should include a specific reference to the version, branch or commit that is to be installed. Note that `librarian-puppet` will also install any required dependant modules.

#### Internal Modules

Internal Modules are the collection of Puppet modules that are considered be specific to this Puppet instance, are not independent (i.e. the may not work reliably outside this manifest), and/or considered part of the whole body of work that makes up the manifest.

More detail on the layout of the internal modules directory can be found in the [internal modules README](modules/README.md).

### Librarian-Puppet

In order for [`librarian-puppet`](http://librarian-puppet.com/) to work with the Dynaguppy framework, two components are required in the Puppet manifest for each directory environment.

* A `Puppetfile` in the root of the directory.
* A `.librarian` configuration directory containing a [configuration file](.librarian/puppet/config)

#### The `Puppetfile`

The `Puppetfile` lists all the external puppet modules to be installed in each directory environment.

An external module must be specified in the `Puppetfile`, and should include a specific reference to the version, branch or commit that is to be installed.

Dependant modules will be auto-resolved by `librarain-puppet`, which may be assisted (or hindered) by specifying a dependency directly in the `Puppetfile` if a specific version is required.

#### The `librarian-puppet` configuration

The `librarian-puppet` [configuration](.librarian/puppet/config) is set up to do two main things;

* Install the external puppet modules in to the `library` folder
* Use `/tmp/librarian-puppet` to cache the External puppet modules.
