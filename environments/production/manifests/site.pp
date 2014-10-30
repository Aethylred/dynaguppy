# This is the root puppet manifest initially installed with
# Dynaguppy https://github.com/Aethylred/dynaguppy

# Setting a preparation stage, this should _only_ be used to 
# configure package repostiories as per the notes here:
# http://docs.puppetlabs.com/puppet/2.7/reference/lang_run_stages.html#limitations-and-known-issues
stage { 'prep_repos':
  before => Stage['main'],
}

$puppet_master_host = 'puppet.local'
$puppetdb_host      = 'puppet.local'
$gitlab_host        = 'git.local'
