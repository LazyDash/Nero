#!/bin/bash

#install nginx
yum install -y nginx

#allow SELinux exception for reverse proxy
setsebool -P httpd_can_network_connect true

#enable and run nginx
systemctl enable nginx
systemctl start nginx
