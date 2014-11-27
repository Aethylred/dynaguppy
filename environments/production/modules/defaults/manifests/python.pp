# This ensures python is installed
class defaults::python {

  class {'::python':
    version => 'system',
    pip     => true,
  }

}