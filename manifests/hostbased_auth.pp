class softec_ssh::hostbased_auth (
  $allowed_hostbased,
) {

  class {'softec_ssh::hostbased_auth::client':
    client_tag  => $allowed_hostbased,
  }

  class {'softec_ssh::hostbased_auth::server':
    allowed_tags  => $allowed_hostbased,
  }

}
