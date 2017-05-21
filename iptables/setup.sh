#!/bin/bash

#reset iptables
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -F

#allow everithing through locahost
iptables -A INPUT -i lo -j ACCEPT

#allow everithing through vpn network
iptables -A INPUT -i tun0 -j ACCEPT

#allow http, https, openvpn through external
iptables -A INPUT -i eth0 -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --sport 80 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --sport 443 -j ACCEPT

#allow DNS
iptables -A INPUT -p udp -i eth0 --sport 53 -j ACCEPT

#allow git
iptables -A INPUT -p tcp -i eth0 --sport 9418 -j ACCEPT

#allow ssh
iptables -A INPUT -p tcp -i eth0 --sport 22 -j ACCEPT

#close of external comunication
iptables -P INPUT DROP

#save configuration
service iptables save

#print configuration
iptables -L -v -n
