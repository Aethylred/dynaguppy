# Dynaguppy Internal Modules

This directory contains the collection of [internal modules](README.md#Internal_Modules) that are not independent of this Puppet Manifest. 

The use of roles and profiles in the Dynaguppy Framework is based on the [presentation and examples](https://github.com/hunner/roles_and_profiles) by [Hunter Haugen](https://github.com/hunner) at [PuppetConf 2013](http://puppetconf.com/), which is in turn was based on a [similar presentation](http://www.slideshare.net/PuppetLabs/roles-talk) given by Craig Dunn at [Puppet Camp Stockholm 2013](http://puppetlabs.com/community/puppet-camp#previous).

## Internal Modules

### `defaults`

This holds a collection of manifest files that describe the default implementation of basic services and resources. Most nodes will use these classes, however exceptions will be common. Check the default [README](modules/defaults/README.md) for more detail.

### `dynaguppy`

These manifests are core to the Dynaguppy Framework integration of Puppet Directory Environments to a git repository on a Gitlab instance. These can be customised further specific to a Puppet managed site's requirements. Check the Dynaguppy module [README](modules/dynaguppy/README.md) for more technical details.

### `profile`

The Profile modules contain classes and resources that define service and application deployments with puppet that are expected to be reused in multiple roles. Check the profile [README](modules/profile/README.md) for more detail.

### `repository`

The Repositories module contains classes that specify where package repositories should be found for you site. Check the repositories [README](modules/repositories/README.md) for more detail.

### `role`

The Role module contains classes that specify a collection of roles and other classes required for a node deployed into a specific role.