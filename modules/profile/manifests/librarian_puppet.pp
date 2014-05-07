class profile::librarian_puppet {
  package{'librarian-puppet':
    ensure    => '1.0.1',
    provider  => 'gem',
    require   => [Package['ruby','puppet','git'],Class['ruby::dev']],
  }
}