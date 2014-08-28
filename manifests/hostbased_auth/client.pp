# == Class: openssh::hostbased_auth::client
# This class enable ssh hostbased authentication client side.
#
# === Parameters
#
# [*client_tag*]
# parameter client_tag is the tag applied to the export fragment.
# on server side varius tag can be collected to allow ssh login by many client
# hosts


class softec_ssh::hostbased_auth::client (
  $client_tag = ""
) {

  $array_addresses=ipaddresses()

  @@concat_fragment { "shosts+002-${fqdn}.tmp":
    #content => ("${fqdn}\n${hostname}\n${ipaddress}\n",
    content => template('softec_ssh/hostbased_auth/shosts_fragment.erb'),
    tag     =>  "${client_tag}",
  }

}
