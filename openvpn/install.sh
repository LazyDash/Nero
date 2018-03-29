#!/bin/bash

#!/bin/bash

#var
LOCAL=`pwd`

#install openvpn and easy-rsa
yum install -y openvpn easy-rsa

#copy easy-rsa to openvpn
mkdir /etc/openvpn/easy-rsa
cp -rf /usr/share/easy-rsa/3.0.3/* /etc/openvpn/easy-rsa

#easy-rsa: create pki
cd /etc/openvpn/easy-rsa
echo "yes" | ./easyrsa init-pki
echo "" | ./easyrsa build-ca nopass
echo "" | ./easyrsa build-server-full server nopass
./easyrsa gen-crl
./easyrsa gen-dh
cd $LOCAL

#copy relevent files to openvpn server folder
cp ./conf/server.conf /etc/openvpn
cp /etc/openvpn/easy-rsa/pki/ca.crt /etc/openvpn
cp /etc/openvpn/easy-rsa/pki/crl.pem /etc/openvpn
cp /etc/openvpn/easy-rsa/pki/dh.pem /etc/openvpn
cp /etc/openvpn/easy-rsa/pki/issued/server.crt /etc/openvpn
cp /etc/openvpn/easy-rsa/pki/private/server.key /etc/openvpn

#openvpn: generate secret key
openvpn --genkey --secret /etc/openvpn/ta.key

#openvpn enable and start service
systemctl enable openvpn@server.service
systemctl start openvpn@server.service
