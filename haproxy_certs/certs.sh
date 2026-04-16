#!/bin/bash

openssl genrsa -out priv.key 4096
openssl req -new -nodes -sha256 -key priv.key -out cert.csr
openssl x509 -req -sha256 -days 3650 -in cert.csr -signkey priv.key -out cert.pem
cat priv.key >> cert.pem
