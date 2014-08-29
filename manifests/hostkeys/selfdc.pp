# Exports hostkeys of the host
# requires: storeconfigs
class softec_ssh::hostkeys::selfdc (
  $cluster_domain   = 'softecspa.it',
  $nodes_domain     = 'selfdc.softecspa.it',
  $backplane_domain = 'selfdc.backplane.softecspa.it'
) inherits softec_ssh::hostkeys {

  $all_aliases= [
    $::fqdn,
    $::hostname,
    "${hostname}.${backplane_domain}",
    "${hostname}.${nodes_domain}",
    "${hostname}.${cluster_domain}",
    ipaddresses(),
  ]

  $aliases = flatten($all_aliases)

  if $::sshdsakey {
    Sshkey["${::fqdn}_dsa"] {
      host_aliases  => $aliases
    }
  }

  if $::sshrsakey {
    Sshkey["${::fqdn}_rsa"] {
      host_aliases  => $aliases
    }
  }

  if $::sshecdsakey {
    Sshkey["${::fqdn}_ecdsa"] {
      host_aliases  => $aliases
    }
  }

}
