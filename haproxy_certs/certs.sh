#!/bin/bash
ARGV=("$@")
ARGC=("$#")
rm -f key.pem && rm -f key.pem.old && rm -f dhparams.pem && rm -f cert.pem
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days `echo 365*4|bc -l` -subj "/C=$1/ST=$2/L=$3/O=$4/CN=$5"
openssl rsa -in key.pem -out newkey.pem && mv key.pem key.pem.old && mv newkey.pem key.pem
openssl dhparam -out dhparams.pem 2048
cat key.pem cert.pem dhparams.pem > certs.pem
