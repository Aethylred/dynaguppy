# This is the Gitlab server
node 'git.local' {
  include defaults
  include role::gitlab
}