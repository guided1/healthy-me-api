Exec {
  path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ]
}

class system-update {
  exec { 'apt-get update':
    command => 'apt-get update'
  }

  exec { 'apt-get upgrade':
    command => 'apt-get upgrade -y',
    require => Exec['apt-get update']
  }
}

class server {
  $packages = ['nodejs', 'mongodb', 'npm']

  package { $packages:
    ensure  => present,
    require => Class['system-update']
  }

  exec { 'update-alternatives node':
    command => 'update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10',
    require => Package[$packages]
  }
}

require server
require system-update