#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "ERROR: No arguments where supplied."
	echo ""
	echo "Usage: revoke-client <name>"
	echo "    - name: the common name of the client for which the certificate will be revoked."
    exit 0
fi

DIR=`pwd`
client=$1

cd /etc/openvpn/easy-rsa/
echo "yes" | ./easyrsa revoke $client

#re-generate the crl file
./easyrsa gen-crl
cp ./pki/crl.pem /etc/openvpn

#remove the client from the ip list of openvpn
sed -i "/$client/d" /etc/openvpn/ipp.txt

cd $DIR
