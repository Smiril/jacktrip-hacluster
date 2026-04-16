#!/bin/bash

openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days `echo 365*4|bc -l` -subj "/C=AT/ST=VIE/L=VIE/O=SELFSIGNED/CN=`hostname -f`"
openssl rsa -in key.pem -out newkey.pem && mv key.pem key.pem.old && mv newkey.pem key.pem
openssl dhparam -out dhparams.pem 2048
cat key.pem cert.pem dhparams.pem > certs.pem
