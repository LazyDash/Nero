#!/bin/bash

#install nginx
yum install nginx

#enable and run nginx
systemctl enable nginx
systemctl start nginx

#generate self signed certificate
mkdir /etc/ssl/private
chmod 700 /etc/ssl/private
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

#add redirect from 80 to 443
mkdir /etc/nginx/default.d
echo "return 301 https://\$host\$request_uri/;" >> /etc/nginx/default.d/ssl-redirect.conf

#enable changes and restart nginx
nginx -t
systemctl restart nginx

#add lazydash.comf
mkdir /etc/nginx/conf.d
cp ./ssl.conf /etc/nginx/conf.d
