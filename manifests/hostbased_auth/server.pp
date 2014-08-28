# == Class: openssh::hostbased_auth::server
# This class enable ssh hostbased authentication server side
#
# === Parameters
#
# [*allowed_tags*] this parameter should be an array of tags that identifies
# wich hosts are allowed to authenticate on the machine.

class softec_ssh::hostbased_auth::server (
  $allowed_tags = ""
){

  file { "/etc/ssh/shosts.equiv":
    ensure  =>  present,
    mode    => 644,
    owner   => root,
    group   => root,
  }

  concat_build { 'shosts':
    order         => ['*.tmp'],
    target        => '/root/.shosts',
  }

  file { "/root/.shosts":
    mode    => 644,
    owner   => root,
    group   => root,
    require => Concat_build['shosts'],
  }

  concat_fragment { "shosts+001.tmp":
    content => '#GENERATED WITH PUPPET using /modules/softec_ssh/manifests/hostbased_auth'
  }


  case $allowed_tags {
    "": {
      Concat_fragment <<| |>>
    }

    default: {
      softec_ssh::hostbased_auth::collect_allowed_hosts{$allowed_tags :}
    }
  }
}
