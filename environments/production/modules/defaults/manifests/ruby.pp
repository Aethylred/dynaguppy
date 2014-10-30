# This sets the default system ruby to Ruby 2.0.0
class defaults::ruby {
  class{'::ruby':
    version            => '2.0.0',
    set_system_default => true,
    latest_release     => true,
  }
  class {'::ruby::dev': }
}