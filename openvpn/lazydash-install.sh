#!/bin/bash
echo "Start"

#updat
yum update -y

#install openvpn
yum install -y epel-release
yum install -y openvpn easy-rsa

#openvpn copy easy-rsa
mkdir -p /etc/openvpn/easy-rsa/keys
cp -rf /usr/share/easy-rsa/2.0/* /etc/openvpn/easy-rsa

#openvpn Copy SSL in order to avoid naming issues
cp /etc/openvpn/easy-rsa/openssl-1.0.0.cnf /etc/openvpn/easy-rsa/openssl.cnf

#openvpn enable service
systemctl enable openvpn@server.service

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

#configure network
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
systemctl restart network.service

#openvpn setup
cp ./server.conf /etc/openvpn/
cp ./vars /etc/openvpn/easy-rsa/

#openvpn move to dir
cd /etc/openvpn/easy-rsa/
source ./vars
./clean-all

#openvpn build server keys
#Build Server Keys
./build-ca
./build-dh
./build-key-server server

#openvpn copy cerificates
cd /etc/openvpn/easy-rsa/keys
cp dh2048.pem ca.crt server.crt server.key /etc/openvpn

#openvpn enable and start service
systemctl enable openvpn@server.service
systemctl start openvpn@server.service

echo "End"
