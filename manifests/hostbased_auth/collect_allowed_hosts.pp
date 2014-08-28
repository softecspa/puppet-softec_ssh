define softec_ssh::hostbased_auth::collect_allowed_hosts {
  Concat_fragment <<| tag =="${name}" |>> {
    require => Class["softec_ssh::knownhosts"]
  }
}
