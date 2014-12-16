# This configures the default install of the ssh client and service
class defaults::ssh {

  if $::trusted and $::trusted['authenticated'] == 'remote' {
    $is_remote = true
  } else {
    $is_remote = false
  }

  class{'::ssh::client':
    storeconfigs_enabled => $is_remote,
  }

  class{'::ssh::server':
    storeconfigs_enabled => $is_remote,
    options => {
      'PermitRootLogin'      => 'no',
      'PubkeyAuthentication' => 'yes',
    },
  }
}