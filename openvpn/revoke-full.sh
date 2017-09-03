#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 0
fi

DIR=`pwd`
client=$1

cd /etc/openvpn/easy-rsa/
source ./vars
./revoke-full $client

cp ./keys/crl.pem /etc/openvpn/crl.pem

sed -i "/$client/d" /etc/openvpn/ipp.txt

cd $DIR
