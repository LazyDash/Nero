#!/bin/bash

#update and install dependencies
yum update -y
yum install -y epel-release
yum install -y git

#configure network
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
systemctl restart network.service
