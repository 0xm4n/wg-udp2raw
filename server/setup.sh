#!/bin/bash

# to enable kernel relaying/forwarding ability on bounce servers
echo "net.ipv4.ip_forward = 1" >>/etc/sysctl.conf
echo "net.ipv4.conf.all.proxy_arp = 1" >>/etc/sysctl.conf
sysctl -p /etc/sysctl.conf

# to add iptables forwarding rules on bounce servers
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wg0 -o wg0 -m conntrack --ctstate NEW -j ACCEPT
iptables -t nat -A POSTROUTING -s 10.144.18.0/24 -o ens4 -j MASQUERADE
