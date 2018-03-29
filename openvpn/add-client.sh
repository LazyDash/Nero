#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "ERROR: No arguments where supplied."
	echo ""
	echo "Usage: add-client <name>"
	echo "    - name: the common name of the client for which the certificate will be created."
    exit 0
fi

DIR=`pwd`
client=$1

cd /etc/openvpn/easy-rsa/
echo "" | ./easyrsa build-client-full $client nopass

mkdir -p $DIR/clients/$1
cp /etc/openvpn/easy-rsa/pki/ca.crt $DIR/clients/$1
cp /etc/openvpn/easy-rsa/pki/issued/$1.crt $DIR/clients/$1
cp /etc/openvpn/easy-rsa/pki/private/$1.key $DIR/clients/$1
cp /etc/openvpn/ta.key $DIR/clients/$1

cp $DIR/conf/client.ovpn $DIR/clients/$1/client.ovpn
echo ca ca.crt$'\r' >> $DIR/clients/$1/client.ovpn
echo cert $1.crt$'\r' >> $DIR/clients/$1/client.ovpn
echo key $1.key$'\r' >> $DIR/clients/$1/client.ovpn
echo tls-auth ta.key 1$'\r' >> $DIR/clients/$1/client.ovpn

cd $DIR

#restart openvpn
systemctl restart openvpn@server.service
