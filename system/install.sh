#!/bin/bash

#install system dependencies
yum install -y epel-release
yum groupinstall -y 'Development Tools'

#configure network for openvpn forward
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
systemctl restart network.service

#install haveged for tomcat start issues and entropy
yum install -y haveged
systemctl enable haveged
systemctl start haveged
