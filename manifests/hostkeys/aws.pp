# Exports hostkeys of the host
# requires: storeconfigs
class softec_ssh::hostkeys::aws (
  $cluster_domain   = 'softecspa.it',
  $nodes_domain     = 'aws.softecspa.it',
  $backplane_domain = 'aws.backplane.softecspa.it'
) inherits softec_ssh::hostkeys {

  $ec2_ip = $ec2_public_ipv4 ? {
    undef   => "",
    default => "$ec2_public_ipv4",
  }

  $aws_local_hostname = $ec2_local_hostname ? {
    undef   => '',
    default => "$ec2_local_hostname",
  }

  $aws_public_hostname = $ec2_public_hostname ? {
    undef   => '',
    default => "$ec2_public_hostname",
  }

  $all_aliases= [
    $::fqdn,
    $::hostname,
    "${hostname}.${backplane_domain}",
    "${hostname}.${nodes_domain}",
    "${hostname}.${cluster_domain}",
    ipaddresses(),
    $ec2_ip,
    $aws_local_hostname,
    $aws_public_hostname
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
