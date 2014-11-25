# This is the Gitlab server
node 'git.local' {
  include defaults
  include role::gitlab

# The following statements set up the dynamic environments managed via git branching
  include dynaguppy::gitlab
}