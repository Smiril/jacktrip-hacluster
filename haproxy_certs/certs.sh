#!/bin/bash

openssl genrsa -out priv.key 4096
openssl req -new -nodes -sha256 -key priv.key -out certs.csr
openssl x509 -req -sha256 -days 365 -in certs.csr -signkey priv.key -out certs.pem
cat priv.key >> certs.pem
