#!/bin/bash

#update and install dependencies
yum install -y epel-release
yum groupinstall 'Development Tools'

#configure network
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
systemctl restart network.service
