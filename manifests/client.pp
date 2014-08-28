class softec_ssh::client inherits ssh::client::config {

  File[$ssh::params::ssh_known_hosts] {
    owner => "root",
    group => "super",
    notify => Service["ssh"],
    require => Group["super"],
  }

}
