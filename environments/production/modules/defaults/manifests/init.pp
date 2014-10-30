class defaults {

  Class['defaults::repositories'] ->
  Class['defaults::ruby'] ->
  Class['defaults::puppet']

  include defaults::repositories
  include defaults::ruby
  include defaults::puppet

}