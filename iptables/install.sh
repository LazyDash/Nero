#!/bin/bash
#install iptables
yum install iptables-services -y

#iptables switch firwall
systemctl mask firewalld
systemctl enable iptables

#iptables enable
systemctl stop firewalld
systemctl start iptables

#iptables configure
iptables --flush
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
iptables-save > /etc/sysconfig/iptables

#run setup
./setup.sh
