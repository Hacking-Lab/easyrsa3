#!/bin/bash
# setup PKI
./easyrsa --batch init-pki
./easyrsa --batch build-ca nopass

# create wildcard cert
FQDN="hacking-lab.local"
CERT_FILENAME="wildcard.${FQDN}"
CERT_COMMONNAME="*.${FQDN}"
./easyrsa --batch --req-cn="${CERT_COMMONNAME}" gen-req ${CERT_FILENAME} nopass
./easyrsa --batch sign-req server ${CERT_FILENAME}
./easyrsa --batch gen-dh


