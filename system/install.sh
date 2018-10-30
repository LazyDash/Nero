#!/bin/bash

#install system dependencies
yum install -y epel-release
yum localinstall -y --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm
yum groupinstall -y 'Development Tools'

#intall optional programs
yum install -y wget iperf3 htop
