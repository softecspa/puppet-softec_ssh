puppet-softec\_ssh
=================

wrapper of softecspa/puppet-ssh

####Table of Contents

1. [Overview](#overview)
2. [Setup](#setup)
 * [Setup requirements](#setup-requirements)
3. [Usage - Configuration options and additional functionality](#usage)
 * [Default config options](#default)
 * [AWS or other environments](#aws-or-other-environments)
 * [Hostbased autentication](#hostbased-authentication)
 * [Override in nodes chain](#override-in-nodes-chain)

##Overview
This module is a wrapper of softecspa/puppet-ssh. It manage client and server configuration, hostbased authentication and hostkeys exchange. By default:
 * install and configure ssh client and server
 * export node's sshkey
 * import sshkey exported from other nodes

By default sshkey will be exported with following aliases:
 * fqdn
 * hostname
 * all ipaddress
 * hostname.softecspa.it
 * hostname.backplane

It's possibile to override aliases by define class parameters or with a new subclass

##Setup
To allow softec nodes inheritance, the better way is to use this class through define key\_exchange. This define allow us to override configuration for hostbased authentication and hostkey aliases.

###Setup Requirements
- softecspa/puppet-ssh
- saz/puppet-ssh
- storedconfig for exported resources

##Usage
### Default
Standard use of this class is to manage both client and server configuration, export its own ssh keys and import ssh keys exported from other nodes:

    softec_ssh::key_exchange {'key_exchange':}

###Aws or other environments
To use in AWS environment ip addresses will be taken from ec2 facts and aliases are in softec aws standard. To accomplish this, there is a subclasses softec\_ssh::hostkeys::aws that inherits from softec\_ssh::hostkeys.
It's possibile to expand this module by create new subclasses and using name in hostkeys\_class parameter.

    softec_ssh::key_exchange{'key_exchange:
        hostkeys_class  => '::aws'
    }

###Hostbased authentication
    softec_ssh::key_exchange{'key_exchange':
      hostbased_auth    => true,
      allowed_hostbased => 'sometag'
    }
each node that includes this define with allowed\_hostbased = 'sometag' are enabled to access to others 'sometags'. Tipical allowed\_hostbased value is $cluster variable.

###Override in nodes chain
    node generic_node {
      softec_ssh::key_exchange {'key_exchange':}
    }

    node aws_node inherits generic_node {
      Softec_ssh::Key_exchange['key_exchange'] {
        hostkey_class  => '::aws'
      }
    }

    node hostbased_node inherits generic_node {
      Softec_ssh::Key_exchange['key_exchange'] {
        hostbased_auth    => true,
        allowed_hostbased => 'a-tag'
      }
    }
