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


# create covenant cert
FQDN="hacking-lab.local"
CERT_FILENAME="covenant.${FQDN}"
CERT_COMMONNAME="covenant.${FQDN}"
./easyrsa --batch --req-cn="${CERT_COMMONNAME}" gen-req ${CERT_FILENAME} nopass
./easyrsa --batch sign-req server ${CERT_FILENAME}


# create full cain.pem
cat ./pki/ca.crt > ./pki/issued/covenant-fullchain.crt
cat ./pki/issued/covenant.hacking-lab.local.crt >> ./pki/issued/covenant-fullchain.crt

# create pfx for covenant
openssl pkcs12 -export -in ./pki/issued/covenant-fullchain.crt -inkey ./pki/private/covenant.hacking-lab.local.key -out ./pki/issued/covenant-fullchain.pfx -name covenant.hacking-lab.local -passout pass:CovenantDev


