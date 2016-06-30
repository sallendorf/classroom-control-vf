class users::admins {
  group { 'lstaff':
    ensure => present,
  }
  
  users::managed_user { 'jose':
  }
    
  users::managed_user { 'alice':
  }
    
  users::managed_user { 'chen':
  }
}
