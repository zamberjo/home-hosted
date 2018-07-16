## Setup Networking
```
docker network create proxy-network
```

## Deploy Traefik
- `docker-compose -f stack-proxy.yml -p proxy up -d`
- *DEVEL*: `docker-compose -f stack-proxy.yml -f stack-proxy.devel.yml -p proxy up -d`

## Deploy rTorrent + Flood
- `mkdir -pv $HOME/{downloads,config}`
- `docker volume create --name flood-data-volume -d local -o o=bind -o type=none -o device=$HOME/downloads`
- `docker volume create --name flood-config-volum -d local -o o=bind -o type=none -o device=$HOME/config`
- `docker-compose -f stack-rtorrent.yml -p rtorrent up -d`
- *RPI*: `docker-compose -f stack-rtorrent.yml -f stack-rtorrent.armhf.yml -p rtorrent up -d`
- *DEVEL*: `docker-compose -f stack-rtorrent.yml -f stack-rtorrent.devel.yml -p rtorrent up -d`

## Deploy Plex
- `docker-compose -f stack-plex.yml -p plex up -d`
- *RPI*: `docker-compose -f stack-plex.yml -f stack-plex.armhf.yml -p plex up -d`
- *DEVEL*: `docker-compose -f stack-plex.yml -f stack-plex.devel.yml -p plex up -d`

## Deploy HomeAssistant
- `mkdir -pv $HOME/homeassistant-data`
- `docker volume create --name homeassistant-data-volume -d local -o o=bind -o type=none -o device=$HOME/homeassistant-data`
- `docker-compose -f stack-homeassistant.yml -p homeassistant up -d`
- *RPI*: `docker-compose -f stack-homeassistant.yml -f stack-homeassistant.armhf.yml -p homeassistant up -d`
- *DEVEL*: `docker-compose -f stack-homeassistant.yml -f stack-homeassistant.devel.yml -p homeassistant up -d`
