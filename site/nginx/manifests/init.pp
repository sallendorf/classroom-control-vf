class nginx (
  $root = undef
){
  case $::osfamily {
    'redhat', 'debian': {
       $pkgname   = 'nginx'
       $owner     = 'root'
       $group     = 'root'
       $defdocroot   = '/var/www'
       $configdir = '/etc/nginx'
       $blockdir  = '/etc/nginx/conf.d'
       $logdir    = '/var/log/nginx'
    }
    'windows': {
       $pkgname   = 'nginx-service'
       $owner     = 'Administrator'
       $group     = 'Administrator'
       $defdocroot   = 'C:/ProgramData/nginx/html'
       $configdir = 'C:/ProgramData/nginx'
       $blockdir  = 'C:/ProgramData/nginx/conf.d'
       $logdir    = 'C:/ProgramData/nginx/logs'
    }
    default: {
      fail("Module not supported on ${::osfamily}")
    }
  }
  
  $svcuser = $::osfamily ? {
    'redhat'  => 'nginx',
    'debian'  => 'www-data',
    'windows' => 'nobody',
  }
  
  $docroot = $root ? {
    undef   => $defdocroot,
    default => $root,
  }
  
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  package {$pkgname:
    ensure => present,
  }
  
  file {[$docroot, "${configdir}/conf.d"]:
    ensure  => directory,
  }
  
  file {"${docroot}/index.html":
    ensure  => file,
    source  => 'puppet:///modules/nginx/index.html',
  }
  
  file {"${configdir}/nginx.conf":
    ensure  => file,
    content => template('nginx/nginx.conf.erb'),
    require => Package[$pkgname],
    notify  => Service['nginx'],
  }
  
  file {"${configdir}/conf.d/default.conf":
    ensure  => file,
    content => template('nginx/default.conf.erb'),
    require => Package[$pkgname],
    notify  => Service['nginx'],
  }
  
  service {'nginx':
    ensure => running,
    enable => true,
  }
}
