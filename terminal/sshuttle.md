## file example

Install:
```
sudo easy_install sshuttle==0.78.5
```

Usually script
```
#!/usr/bin/expect
proc get_ips { fqdn } {
	set output [exec sh -c "dig A ${fqdn} | egrep '^${fqdn}' | awk '{print \$5}'"]
	set ips [join [split $output "\n"] " "]
	return $ips
}
set code [lindex $argv 0]
# IP List
set ip_list ""
## list ips
set ip_list "${ip_list} 10.5.0.0/16"
set ip_list "${ip_list} 10.20.0.0/16"
set ip_list "${ip_list} 10.30.0.0/16"
set ip_list "${ip_list} 10.40.0.0/16"
set ip_list "${ip_list} 10.50.0.0/16"
set ip_list "${ip_list} 10.51.0.0/16"
set ip_list "${ip_list} 10.70.0.0/16"
set ip_list "${ip_list} 10.90.0.0/16"
set ip_list "${ip_list} 10.100.0.0/16" 
set ip_list "${ip_list} 10.110.0.0/16" 
set ip_list "${ip_list} 10.150.0.0/16" 
set ip_list "${ip_list} 10.200.0.0/16"
set ip_list "${ip_list} 52.87.0.0/16"
set ip_list "${ip_list} 54.0.0.0/8"
set ip_list "${ip_list} 52.0.0.0/8"
# metabase
set metabase [get_ips "metabase-dns"]
set ip_list "${ip_list} ${metabase}" 
# jenkins.moip.com.br
set jenkins [get_ips "jenkins-dns"]
set ip_list "${ip_list} ${jenkins}"  
# Kibanas
set elk_prod [get_ips "elk-dns"]
set elk_sand [get_ips "elk-dns"]
set elk_hmlg [get_ips "elk-dns"]
set ip_list "${ip_list} ${elk_prod} ${elk_sand} ${elk_hmlg}"
# Elastic Search
set elk_financial [get_ips "elk_dns"]
set ip_list "${ip_list} ${elk_financial}"
eval spawn sshuttle --dns --remote user@server_dns:port ${ip_list}
interact

```