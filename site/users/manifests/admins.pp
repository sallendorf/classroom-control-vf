class users::admins {
  group { 'lstaff':
    ensure => present,
  }
  
  users::managed_user { 'jose':
    group => lstaff',
  }
    
  users::managed_user { 'alice':
  }
    
  usres::managed_user { 'chen':
    group => 'lstaff',
  }
}
