class profile::librarian_puppet {
  if versioncmp($::rubyversion, '1.9.3') < 0 {
    $librarian_puppet_version = '1.0.1'
  } else {
    $librarian_puppet_version = '1.1.2'
  }
  package{'librarian-puppet':
    ensure    => $librarian_puppet_version,
    provider  => 'gem',
    require   => [Package['ruby','puppet','git'],Class['ruby::dev']],
  }
}