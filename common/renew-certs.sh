#!/bin/bash

# I'm not sure exactly where this should up or
# if it'll work when it's run the first time, but
# this should just be a matter of making configuration
# changes - Nick B.

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

set -e

if [ -n `which letsencrypt` ]; then
  echo "Installing letsencrypt..."
  apt-get install -y letsencrypt
fi

echo
echo -n "Enter the name of the domain: "
read DOMAIN

mkdir -p `pwd`/.well-known/acme-challenge

echo
echo "Beginning ACME Challenge..."
sudo letsencrypt certonly --webroot -w . -d $DOMAIN

CERT_DIR=/etc/letsencrypt/live/$DOMAIN
mkdir -p `pwd`/certs
cp $CERT_DIR/{cert.pem,privkey.pem,chain.pem} `pwd`/certs
