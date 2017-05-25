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
KEY_CN=$1
./build-key --batch $1


cd ./keys/
mkdir -p $DIR/clients/$1
cp $1.crt $1.key ca.crt $DIR/clients/$1/

cd $DIR
cp ./conf/client.ovpn ./clients/$1/client.ovpn

cd $DIR/clients
cp /etc/openvpn/ta.key ./$1

echo ca ca.crt$'\r' >> ./$1/client.ovpn
echo cert $1.crt$'\r' >> ./$1/client.ovpn
echo key $1.key$'\r' >> ./$1/client.ovpn
echo tls-auth ta.key 1$'\r' >> ./$1/client.ovpn

#restart openvpn
systemctl restart openvpn@server.service
