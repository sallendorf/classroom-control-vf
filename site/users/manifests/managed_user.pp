define users::managed_user (
  $group = $title,
) {
  user { $title:
    ensure => present,
    gid    => $group,
  }

  group { "group_${title}":
    ensure => present,
    name => $group,
  }
  
  file { ["/home/${title}", "/home/${title}/public_html"]:
    ensure => directory,
    owner => $title,
    group => $group,
  }
    file { "/home/${title}/.ssh":
    ensure => directory,
    owner => $title,
    group => $group,
    mode => '0700',
  }
}
