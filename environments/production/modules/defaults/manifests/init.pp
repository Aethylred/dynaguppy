class defaults (
  $repositories = true,
  $ruby         = true,
  $puppet       = true
) {

  include defaults::sudo

  if $repositories {
    include defaults::repositories
  }
  if $ruby {
    if $repositories {
      Class['defaults::repositories'] -> Class['defaults::ruby']
    }
    include defaults::ruby
  }
  if $puppet {
    if $ruby {
      Class['defaults::ruby'] -> Class['defaults::puppet']
    }
    if $repositories {
      Class['defaults::repositories'] -> Class['defaults::puppet']
    }
    include defaults::puppet
  }

}