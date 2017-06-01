#!/bin/bash

#reset iptables
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -F

#allow everithing through locahost
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#allow everithing through vpn network
iptables -A INPUT -i tun0 -j ACCEPT
iptables -A OUTPUT -o tun0 -j ACCEPT

#allow everithing through docker network
iptables -A INPUT -i docker0 -j ACCEPT
iptables -A OUTPUT -o docker0 -j ACCEPT

#allow http
iptables -A INPUT -i eth0 -p tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 80 -m conntrack --ctstate ESTABLISHED -j ACCEPT

iptables -A OUTPUT -o eth0 -p tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --sport 80 -m conntrack --ctstate ESTABLISHED -j ACCEPT

#allow https
iptables -A INPUT -i eth0 -p tcp --dport 443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 443 -m conntrack --ctstate ESTABLISHED -j ACCEPT

iptables -A OUTPUT -o eth0 -p tcp --dport 443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --sport 443 -m conntrack --ctstate ESTABLISHED -j ACCEPT

#allow openvpn
iptables -A INPUT -i eth0 -p tcp --dport 1194 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 1194 -m conntrack --ctstate ESTABLISHED -j ACCEPT

#allow DNS
iptables -A OUTPUT -o eth0 -p udp --dport 53 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth0 -p udp --sport 53 -m conntrack --ctstate ESTABLISHED -j ACCEPT

#allow git
iptables -A OUTPUT -o eth0 -p tcp --dport 9418 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --sport 9418 -m conntrack --ctstate ESTABLISHED -j ACCEPT

iptables -A OUTPUT -o eth0 -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

#close of external comunication
iptables -P INPUT DROP
iptables -P OUTPUT DROP

#save configuration
service iptables save

#print configuration
iptables -L -v -n
