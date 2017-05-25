#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 0
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
client=$1

cd /etc/openvpn/easy-rsa/
source ./vars
./build-key $1

cd ./keys/
mkdir -p $DIR/clients/$1
cp $1.crt $1.key ca.crt $DIR/clients/$1/

cp ./conf/client.ovpn ./clients/$1/client.ovpn
cd $DIR
echo ca ca.crt$'\r' >> ./clients/$1/client.ovpn
echo cert $1.crt$'\r' >> ./clients/$1/client.ovpn
echo key $1.key$'\r' >> ./clients/$1/client.ovpn

#restart openvpn
systemctl restart openvpn@server.service
