class users::admins {
#  group { 'lstaff':
#    ensure => present,
#  }
  
  users::managed_user { 'jose':
    group => 'lstaff',
  }
    
  users::managed_user { 'alice':
  }
    
  users::managed_user { 'chen':
    group => 'lstaff',
  }
}
