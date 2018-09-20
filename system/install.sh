#!/bin/bash

#install system dependencies
yum install -y epel-release
yum localinstall -y --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm
yum groupinstall -y 'Development Tools'
yum install -y wget

#install monospace font
yum install -y gnu-free-mono-fonts

#configure network for openvpn forward
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
systemctl restart network.service

#install haveged for tomcat start issues and entropy
yum install -y haveged
systemctl enable haveged
systemctl start haveged
