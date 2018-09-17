# EmeraldCryptoCoin
Create a node for Emerald Crypto Coins with Docker.

To build and run emerald docker container use the following commands:
```
docker build -t emerald/node:1.0 .
docker volume create emerald-volume
docker run -d \
  --name emerald \
  --restart always \
  -v emerald-volume:/data \
  emerald/node:1.0
```