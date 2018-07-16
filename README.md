## Setup Networking
```
docker network create proxy-network
```

## Deploy Traefik
- `docker-compose -f stack-proxy.yml -p proxy up -d`
- *DEVEL*: `docker-compose -f stack-proxy.yml -f stack-proxy.devel.yml -p proxy up -d`

## Deploy ruTorrent
- `mkdir -pv /{downloads,config}`
- `docker volume create --name flood-data-volume -d local -o o=bind -o type=none -o device=/mnt/external/rtorrent/downloads`
- `docker volume create --name flood-config-volum -d local -o o=bind -o type=none -o device=/mnt/external/rtorrent/watch`
- `docker-compose -f stack-rtorrent.yml -p rtorrent up -d`
- *RPI*: `docker-compose -f stack-rtorrent.yml -f stack-rtorrent.armhf.yml -p rtorrent up -d`
- *DEVEL*: `docker-compose -f stack-rtorrent.yml -f stack-rtorrent.devel.yml -p rtorrent up -d`
