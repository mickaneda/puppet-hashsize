class hashsize(
  $conf_path = "/etc/modprobe.d/nf_conntrack.conf",
  $hashsize_path = "/sys/module/nf_conntrack/parameters/hashsize",
  $hashsize = "16384",
  $nf_conntrack_max = "131072"
){
  file {"nf_conntrack.conf":
    path => $conf_path,
    content => "options nf_conntrack hashsize=${hashsize}",
    owner => root,
    group => root,
    mode => 0644,
  }
  exec {"${name} exec":
    command =>  "echo ${hashsize} > ${hashsize_path}"
  }
  exec {"change hashsize":
    command => "sysctl -w net.netfilter.nf_conntrack_max=${nf_conntrack_max}"
  }
}
