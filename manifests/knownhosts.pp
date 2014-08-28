class softec_ssh::knownhosts inherits ssh::client::config{

  File[$ssh::params::ssh_known_hosts] {
    owner => "root",
    group => "super",
    notify => Service["ssh"],
    require => Group["super"],
  }

  class {'ssh::knownhosts':}

  /*augeas { "ssh_config_knownhosts":
    context => "/files/etc/ssh/ssh_config/Host[.='*']",
    changes => [
      "set UserKnownHostsFile /etc/ssh/ssh_known_hosts",
    ],
    require => [ Class["puppet"], Package["openssh-server"], ],
  }

  # Fx - Chiavi dei vernacoli aggiunte manualmente visto che sui vernacoli non
  # esiste l'agent
  sshkey { "vernacolo02.softecspa.it_dsa":
    host_aliases  =>  [
      "vernacolo02.softecspa.it",
      "vernacolo02",
      "77.238.6.146",
      "192.168.34.197",
      "vernacolo02.backplane",
      "svn.softecspa.it",
      "77.238.6.155",
    ],
    type          =>  dsa,
    key           => "AAAAB3NzaC1kc3MAAACBAIc9y5R2SIAPzyC0YuPhluevjgKGHBmqrwLltmqVsmbdiOsk/SYanBloxdMDSOyHcFu+f2j0HE1I+iIHgJ+Yx4xnJUo7vnoVPr/BOXKsDj9Vah/D4F7lWOoFwpJ5mY5tIJhb/ruL2J2gmqUR8r3D+qaHOwpUkkeHxDAIvqRcYnpnAAAAFQDbIWmTftytXM57DI5clQ86Tij5gQAAAIBRWR3Mw8Vl/3vIe/KL600PKbIxvv+rClWrnUm9m4IaZyXBH8y/EGkYe1DW3Cv02o7WhI6sawKlf47y64YvGFJt5u14JHLe+KBYNuayv1RcUsNe5bPk2Ab2ea9EgSDzJw5+176rRxLrPvLXgvZhBCeYAeg5YEEVuog8qFp+JAbT9QAAAIAaJoF9B8cqAg9rWyT12J2SGWx97xNP7tRf2HARhWCmLoQN4e5AbG2uPPWP0aA2CAA7FBgSTnibJxsB9+VS3uD22LEfDlo/wnjCmWj7xtxnCnSqs2VLkET5parGSwo1Y13AaGPrvPU37Iq+1VTPfJeNsD8JcI+YIdrXwy6YnOqGsQ==",
  }

  sshkey { "vernacolo02.softecspa.it_rsa":
    host_aliases  => [
      "vernacolo02.softecspa.it",
      "vernacolo02",
      "77.238.6.146",
      "192.168.34.197",
      "vernacolo02.backplane",
      "svn.softecspa.it",
      "77.238.6.155",
    ],
    type          => rsa,
    key           => "AAAAB3NzaC1yc2EAAAABIwAAAQEAq8ICA2SpEdIS1d1a9SVpf/GyiVDKetYhlT2Niem5WyLzIcrkpPfL53ecoKwyNcSQ4jCycLh86HAfIZdm1xYrq6LxUbl6OwUGUfzbjqpwP/CHP23qJUcC5sJ/yDjz/xgSOoe2iVpVXJCyL7fhe4LY+rpxYbvgQ75wx1MFzcwNcab6fZvhd+i5kj5SqfRhWGhbXcUooKa8oRjySEAnYZd6s+OZQBZaAUbT6fZO0zOfWq7L673wKKVOK2o+I3b53XS6kfwBdiXNYZi561SYYVCTjoWtgIl5nNu1E08TVwRmBPeL2Loxsbo/UNDMX4Fz2uk4+9viEKFB0Jwa8x2QBw7ooQ==",
  }

  # Chiavi cucciolo e brontolo

 sshkey { "brontolo.softecspa.it_rsa":
    host_aliases  => [
      "brontolo.softecspa.it",
      "brontolo",
      "172.16.32.154",
      "brontolo.backplane",
      "192.168.32.154",
    ],
    type          => rsa,
    key           => "AAAAB3NzaC1yc2EAAAABIwAAAQEAv0SA5y0ndD7xFcjD4Y+WT4sx2svVNrTs1p80zwGiz4DsDonXxp2eOt54TEk8i703ptTjRAts4EniVDi4QYOaWy2v1TobEg6ccZwDY7M9suXoxP/Sz3Q9jzAEAyQ1DDshdIjuy4naQBDBfjU5KHTjdYE+eykLvqNKHq2DabislFFNL8HVHmldZARs8l8s4YAj7h+QtQhWadh/H+cdgopwo5xaXMMBbPDAvEtrPPxRrG2zD61WDKxt4M/uVTBXaiZNVcYS0kiMLEMS6OC1kTS6PBRXtEbpw3OA1XVPUB+hs5lgwad65yZ8bJVjZrBbY/jO4RDIXEUy3F3VffiF08yk3Q==",
  }

  sshkey { "brontolo.softecspa.it_dsa":
    host_aliases  => [
      "brontolo.softecspa.it",
      "brontolo",
      "172.16.32.154",
      "brontolo.backplane",
      "192.168.32.154",
    ],
    type          => dsa,
    key           => "AAAAB3NzaC1kc3MAAACBAMBHVq8EG8ajnAPlta4p/91WTaSLq9NNH/bst/8wksuQDa/zzOvZllQRrK7xwYsIzFCqJFbp4P8S9m5FjD47B/spsmfSFWMaSsYlKLKLxQ8M8qzy8/NAbxPRnoUwLXLPg/m+lsRH7RUxEDm2h8TRcCDbsKkQzbh2fyW1yRz0fFXdAAAAFQDKcOpsVodnHAq/yZG677RrryOD3wAAAIEAni3apvcxyc9H/8xekVHODoOdWf8u61ytxqm+EdjOQcQu7+Bud5RX5JVUwNcSAu6XOKvv7FXHN6i8z1QlcWJGiQBrQpk+37u8m0S+4GVh2Iu8gDEoKHKpjgjCHqD2ljsLtPUfnR20pnueK3Ev3WriyNf5jSaQV2A0mfoSYpU9jD8AAACAUoO8wXUs9SAEefVK5BsLEh+jGoBo+yDfKUp5pVxGV8s/YZJgSUfdIWLcqF0fwLQIYSDggeV2lziNKYiNcF3UB6t+bA7TrXYa1lje5ScyvLSU/vEphg5MwDxmKD+eBx8AsU4UC/M/k5H2Qe/r3uWKIZiSREK99JvJrrE+YNi4AMg=",
  }


  sshkey { "cucciolo.softecspa.it_rsa":
    host_aliases  => [
      "cucciolo.softecspa.it",
      "cucciolo",
      "172.16.32.155",
      "cucciolo.backplane",
      "192.168.32.155",
    ],
    type          => rsa,
    key           => "AAAAB3NzaC1yc2EAAAABIwAAAQEAubrZOSc3HK79aglEPNhiRruE9gWfd/Hql9l8CaOE6jp31LuPBsOHjLW2WKlIhi0es6H+6YVs/6ily/0Kd2ob7+oeopAnnzD3JSD6YK4ac1EcW4aomBdPs7U1AuJLIDlH9VSnxKqxKEQMpt4oiydOV6Dz7rxe7JUiMHjFkTe8uH1sJryaajq0PwHD3bXTelOJZQS2tT9Z0MVcltOIEa6tazywo/WKLMia13MIrPb1IOBwCzCWXPWZtmvuxN7pWpKOvVzDRItTYINMbUXtFaHK7cjTBPXU2qGc7oFM/uDs7KMHcy6ciZCsZMsp6ItU4702kKJK8KPVq1WRT0JrpC3Stw==",
  }

  sshkey { "cucciolo.softecspa.it_dsa":
    host_aliases  => [
      "cucciolo.softecspa.it",
      "cucciolo",
      "172.16.32.155",
      "cucciolo.backplane",
      "192.168.32.155",
    ],
    type          => dsa,
    key           => "AAAAB3NzaC1kc3MAAACBAOPfW6H67mNId/BaY3C0k/mB21fhmSp8Y5QBqv0VnNFmxTWKAKPs5uDbvwz3RVJVMZjnJ5PzvIqU/98rImaQ6wo+gsLJNBs8+YbZNvdDo+p9Sa2lRWq/oSCJicd2AA6T8hxhR+ft9LyupvpiFvZASjqToynGDWu4HWGSlGP97eStAAAAFQCk7xmflBBnIQordCRy9/zmMEL8kQAAAIAwOaKTCUGlEwsXBLgvNhjkJdfVqFc+1lndlFjyQpTNcoOmli3XdAS6WNUC320Oyo3V562t+ku2IV7OykYwO6VRcIS3iG4tph4qTuVQOTKzaND7x0h0Ur1hcTGBKoOAbO8XAx2ouOG3gITJ4po6lE2/4qiJU7ZBckq3dfBnuBe5MAAAAIAb5w4VyETfkVLP0tjTxTQF/m/kL8YCM7kHlE2pORF6Dt/BRRGK1xmn+bNW1NrbnDDtodHaWwcqIpll/XcA99VNgLzzF2Iv0nki4XKMsZv98IwZ9j6jy1EKVMsItfTDWGIKPpDZdmUP7kJyue3fEEUBZuCFWa2pZBfQrNObeOaUSA==",
  }*/
}
