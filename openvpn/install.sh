#!/bin/bash

#install openvpn
yum install -y openvpn easy-rsa

#generate secret key
openvpn --genkey --secret /etc/openvpn/ta.key

#openvpn copy easy-rsa
mkdir -p /etc/openvpn/easy-rsa/keys
cp -rf /usr/share/easy-rsa/2.0/* /etc/openvpn/easy-rsa

#openvpn Copy SSL in order to avoid naming issues
cp /etc/openvpn/easy-rsa/openssl-1.0.0.cnf /etc/openvpn/easy-rsa/openssl.cnf

#openvpn enable service
systemctl enable openvpn@server.service

#openvpn setup
cp ./conf/server.conf /etc/openvpn/
cp ./conf/vars /etc/openvpn/easy-rsa/

#openvpn move to dir
cd /etc/openvpn/easy-rsa/
source ./vars
./clean-all

#openvpn build server keys
./build-ca
./build-dh
./build-key-server server

#openvpn copy cerificates
cd /etc/openvpn/easy-rsa/keys
cp dh2048.pem ca.crt server.crt server.key /etc/openvpn

#generate test client and revoke certificate
./build-key.sh test
./revoke-full.sh test

#openvpn enable and start service
systemctl enable openvpn@server.service
systemctl start openvpn@server.service
