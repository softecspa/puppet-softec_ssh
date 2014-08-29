define softec_ssh::key_exchange (
  $cluster_domain     = 'softecspa.it',
  $nodes_domain       = 'softecspa.it',
  $backplane_domain   = 'backplane',
  $hostbased_auth     = false,
  $allowed_hostbased  = '',
  hostkeys_class      = '',
  listen_address      = '*',
)
{
  #configura ssh ed esporta  le chiavi
  class {'softec_ssh':
    cluster_domain    => $cluster_domain,
    nodes_domain      => $nodes_domain,
    backplane_domain  => $backplane_domain,
    hostbased_auth    => $hostbased_auth,
    allowed_hostbased => $allowed_hostbased,
    hostkeys_class    => $hostkeys_class,
    listen_address    => $listen_address
  }

}
