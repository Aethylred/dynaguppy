# Puppet Node Manifests

This directory contains the manifests for the puppet site and all the nodes under puppet management control.

## Contents

This directory will contain:

* This `README.md` file.
* A manifest ([site.pp]) for the whole Puppet site.
* A collection of puppet node manifest files.

This directory may contain:

* A default manifest ([default.pp]), though this is not included in the initial Dynaguppy Framework.

## Node Manifests

The node manifest files should be named using the fully qualified domain name (FQDN) as resolved by facter on the node being managed and each file should hold the manifest for a single node. However some deployments may use puppet node naming features that may vary this recommendation, such as grouping similar nodes into a single manifest by name or with regular expressions, or by issuing a Puppet back end certificate with a name that does not match a nodes FQDN (e.g. for aliasing purposes such as when a node's internal hostname does not match it's public hostname, which is common in load balancing configurations).

The use of subdirectories to organise node groupings can implemented by using include statements in the `site.pp` manifest, though this is not recommended unless there are a very large number of nodes.

## Roles

The Dynaguppy Framework is uses roles and profiles as described in the [presentation and examples](https://github.com/hunner/roles_and_profiles) by [Hunter Haugen](https://github.com/hunner) at [PuppetConf 2013](http://puppetconf.com/), which is in turn was based on a [similar presentation](http://www.slideshare.net/PuppetLabs/roles-talk) given by Craig Dunn at [Puppet Camp Stockholm 2013](http://puppetlabs.com/community/puppet-camp#previous).

Each node manifest should be short and contain only classes and resources that manage low level system requirements or defaults. The main functionality of the node should be implemented using a role defined in the [role module](modules/role). This separation makes it clear that the resources managed in the base node manifest are low level and not the role that if fulfils. These definitions should either be specific to the system, platform, or hardware the node is running on (e.g. network settings, or vmware tools setup), or generic defaults applied across all nodes in the site (e.g. a default ntp configuration)