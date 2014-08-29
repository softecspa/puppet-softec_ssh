class softec_ssh (
  $server_options   = {
    'Port'                    => '22',
    'PermitRootLogin'         => 'without-password',
    'Protocol'                => '2',
    'HostKey'                 => ['/etc/ssh/ssh_host_rsa_key','/etc/ssh/ssh_host_dsa_key','/etc/ssh/ssh_host_ecdsa_key'],
    'UsePrivilegeSeparation'  => 'yes',
    'KeyRegenerationInterval' => '3600',
    'ServerKeyBits'           => '768',
    'SyslogFacility'          => 'AUTH',
    'LogLevel'                => 'INFO',
    'LoginGraceTime'          => '120',
    'StrictModes'             => 'yes',
    'RSAAuthentication'       => 'yes',
    'PubkeyAuthentication'    => 'yes',
    'RhostsRSAAuthentication' => 'no',
    'PermitEmptyPasswords'    => 'no',
    'X11DisplayOffset'        => '10',
    'PrintLastLog'            => 'yes',
    'TCPKeepAlive'            => 'yes',
    'Subsystem'               => 'sftp /usr/lib/openssh/sftp_server.sh',
    'UseDNS'                  => 'no',
  },
  $client_options   = {
    'Host *'                 => {
      'SendEnv'                   => 'LANG LC_*',
      'HashKnownHosts'            => 'yes',
      'GSSAPIAuthentication'      => 'yes',
      'GSSAPIDelegateCredentials' => 'no',
      'UserKnownHostsFile'        => '/etc/ssh/ssh_known_hosts'
    },
  },
  $cluster_domain     = undef,
  $nodes_domain       = undef,
  $backplane_domain   = undef,
  $hostbased_auth     = false,
  $allowed_hostbased  = '',
  $hostkeys_class     = '',
  $listen_address     = '*',
) {

## configuration for client and server based ho hostbased_auth ##

  if ($hostbased_auth) {
    $hostbased_server_options = {
      'HostbasedAuthentication'         => 'yes',
      'IgnoreUserKnownHosts'            => 'yes',
      'IgnoreRhosts'                    => 'no',
      'HostbasedUsesNameFromPacketOnly' => 'yes',
    }
    $hostbased_client_options = {
      'EnableSSHKeysign'        => 'yes',
      'HostbasedAuthentication' => 'yes',
    }
  } else {
    $hostbased_server_options = {
      'HostbasedAuthentication' => 'no',
      'IgnoreRhosts'            => 'yes',
    }
    $hostbased_client_options = {}
  }

  $merged_server_options = merge ($server_options, $hostbased_server_options)
  $merged_client_options = merge ($client_options, $hostbased_client_options)
### push script for sftp features

  file { "/usr/lib/openssh/sftp_server.sh":
    ensure  => present,
    mode  => 755,
    owner => root,
    group => root,
    source  => "puppet:///modules/softec_ssh/sftp_server.sh",
  }

### saz/puppet-ssh classes with customized parameters ###

  class { 'ssh::server':
    options               => $merged_server_options,
    storeconfigs_enabled  => false
  }

  class { 'ssh::client':
    storeconfigs_enabled  => false,
    options               => $merged_client_options,
  }

### hostkeys exchange based on environment for aliases ###

  class {"softec_ssh::hostkeys${hostkeys_class}":
    cluster_domain    => $cluster_domain,
    nodes_domain      => $nodes_domain,
    backplane_domain  => $backplane_domain,
  }
  class {'softec_ssh::knownhosts':}

#### hostbased auth #######
  if ($hostbased_auth) {
    if ($allowed_hostbased == '') {
      fail('if hostbased auth is enabled, allowed_hostbased must be specified.')
    } else {
      class {'softec_ssh::hostbased_auth':
        allowed_hostbased => $allowed_hostbased,
      }
    }
  }

}
