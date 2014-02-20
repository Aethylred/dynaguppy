class profile::librarian_puppet {
  package{'librarian-puppet':
    ensure    => '0.9.10',
    provider  => 'gem',
    require   => [Package['ruby','ruby-dev','puppet','git']],
  }
}