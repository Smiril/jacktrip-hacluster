#!/bin/bash
ARGV=("$@")
ARGC=("$#")
rm -f key.pem && rm -f ca-key.pem && rm -f cert.pem  && rm -f ca-cert.pem && rm -f server-key.pem && rm -f server-req.pem && rm -f server-cert.pem && rm -f dhparams.pem && rm -f certs.pem
openssl genpkey -algorithm RSA -out key.pem
openssl req -new -x509 -key key.pem -out cert.pem -days 365 
openssl x509 -text -noout -in cert.pem
openssl genrsa $1 > ca-key.pem
openssl req -new -x509 -nodes -days 365 -key ca-key.pem  -out ca-cert.pem
openssl req -newkey rsa:$1 -nodes -days 365 -keyout server-key.pem  -out server-req.pem
openssl x509 -req -days 365 -set_serial 01  -in server-req.pem  -out server-cert.pem  -CA ca-cert.pem  -CAkey ca-key.pem
openssl verify -CAfile ca-cert.pem ca-cert.pem server-cert.pem
openssl dhparam -out dhparams.pem 2048
cat server-req.pem server-cert.pem dhparams.pem > certs.pem

exit 0
