#!/bin/bash

if ! [ -x "$(command -v docker-compose)" ]; then
  echo 'Error: docker-compose is not installed.' >&2
  exit 1
fi

domains=(fqdn.example.org)
rsa_key_size=4096
country="AT"
state="VIE"
city="VIE"
data_path="./haproxy_certs"
email="" # Adding a valid address is strongly recommended
staging=0 # Set to 1 if you're testing your setup to avoid hitting request limits

if [ -d "$data_path" ]; then
  read -p "Existing data found for $domains. Continue and replace existing certificate? (y/N) " decision
  if [ "$decision" != "Y" ] && [ "$decision" != "y" ]; then
    exit
  fi
fi


if [ ! -e "./ha-proxy.cfg" ] || [ ! -e "$data_path/certs.sh" ]; then
  echo "### Downloading recommended TLS parameters ..."
  mkdir -p $data_path
  curl -s https://raw.githubusercontent.com/Smiril/jacktrip-hacluster/blob/main/ha-proxy.cfg > "./ha-proxy.cfg"
  curl -s https://raw.githubusercontent.com/Smiril/jacktrip-hacluster/blob/main/haproxy_certs/certs.sh > "$data_path/certs.sh"
  echo
fi

echo "### Creating selfsigned certificate for $domains ..."
./haproxy_certs/certs.sh $contry $state $city $email $domains
echo


echo "### Starting haproxy ..."
docker-compose up --force-recreate -d haproxy
echo

# Enable staging mode if needed
if [ $staging != "0" ]; then staging_arg="--staging"; fi

echo "### Reloading haproxy ..."
docker-compose exec haproxy haproxy reload
