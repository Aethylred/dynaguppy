# Sets up sudo
class defaults::sudo{

  # This should grab settings from hiera
  class { '::sudo':
      enable              => true,
      purge               => true,
      config_file_replace => true,
    }

}
