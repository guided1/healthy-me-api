Exec {
  path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ]
}

class system-update {
  exec { 'apt-get update':
    command => 'apt-get update',
  }
}

class server {
  $packages = ["nodejs", "mongodb"]

  package { $packages:
    ensure  => present,
    require => Class["system-update"]
  }

  exec { 'update-alternatives node':
    command => 'update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10',
    require => Package[$packages]
  }
}

class node-packages {

}

require server
require system-update