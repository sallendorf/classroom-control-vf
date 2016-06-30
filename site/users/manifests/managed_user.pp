define users::managed_user (
  $group = $title,
) {
  user { $title:
    ensure => present,
    gid    => $group,
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
