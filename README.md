# jacktrip-hacluster
how to docker a ha cluster for jacktrip servers


# Setup
```
cd haproxy_certs/
bash ./certs.sh 4096 365
```

```
docker-compose up -d
```
# Or simply run

```
bash ./init-setup.sh
```
# To stop the container run

```
docker-compose down
```

