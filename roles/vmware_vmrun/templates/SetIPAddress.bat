@echo off
netsh interface ipv4 set address name="Ethernet0" source=static address={{ ansible_ssh_host }} mask={{ ipv4_netmask }} gateway={{ ipv4_gateway }}
netsh interface ipv4 add dnsserver name="Ethernet0" address={{ ipv4_nameserver }} index=1
