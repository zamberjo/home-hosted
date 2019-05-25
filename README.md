## Setup Networking
```
docker network create proxy-network
docker network create postgres-network
docker network create redis-network
```

## Deploy PostgreSQL
- `docker-compose -f stack-postgres.yml -p postgres up -d`

## Deploy Redis
- `docker-compose -f stack-redis.yml -p redis up -d`

## Deploy Traefik
- `docker-compose -f stack-proxy.yml -p proxy up -d`
- *DEVEL*: `docker-compose -f stack-proxy.yml -f stack-proxy.devel.yml -p proxy up -d`

## Deploy rTorrent + Flood
- `mkdir -pv $HOME/{downloads,watch,incoming,couchpotato}`
- `mkdir -pv $HOME/jackett/{config,blackhole}`
- `docker volume create --name rtorrent-incoming-volume -d local -o o=bind -o type=none -o device=$HOME/incoming`
- `docker volume create --name rtorrent-downloads-volume -d local -o o=bind -o type=none -o device=$HOME/downloads`
- `docker volume create --name rtorrent-watch-volume -d local -o o=bind -o type=none -o device=$HOME/watch`
- `docker volume create --name couchpotato-volume -d local -o o=bind -o type=none -o device=$HOME/couchpotato`
- `docker volume create --name jackett-blackhole-volume -d local -o o=bind -o type=none -o device=$HOME/jackett/blackhole`
- `docker volume create --name jackett-config-volume -d local -o o=bind -o type=none -o device=$HOME/jackett/config`
- `docker-compose -f stack-rtorrent.yml -p rtorrent up -d`
- *RPI*: `docker-compose -f stack-rtorrent.yml -f stack-rtorrent.armhf.yml -p rtorrent up -d`
- *DEVEL*: `docker-compose -f stack-rtorrent.yml -f stack-rtorrent.devel.yml -p rtorrent up -d`
- *USE*: `tvshows` and `movies` tags

## Deploy Plex
- `mkdir -pv $HOME/plex/config`
- `docker volume create --name plex-config-volume -d local -o o=bind -o type=none -o device=$HOME/plex/config`
- `docker-compose -f stack-plex.yml -p plex up -d`
- *RPI*: `docker-compose -f stack-plex.yml -f stack-plex.armhf.yml -p plex up -d`
- *DEVEL*: `docker-compose -f stack-plex.yml -f stack-plex.devel.yml -p plex up -d`

## Deploy HomeAssistant
- `mkdir -pv $HOME/homeassistant-config`
- `docker volume create --name homeassistant-config-volume -d local -o o=bind -o type=none -o device=$HOME/homeassistant-config`
- `docker-compose -f stack-homeassistant.yml -p homeassistant up -d`
- *RPI*: `docker-compose -f stack-homeassistant.yml -f stack-homeassistant.armhf.yml -p homeassistant up -d`
- *DEVEL*: `docker-compose -f stack-homeassistant.yml -f stack-homeassistant.devel.yml -p homeassistant up -d`

## Prometheus
- `docker-compose -f stack-prometheus.yml -p prometheus up -d`
- *RPI*: `docker-compose -f stack-prometheus.yml -f stack-prometheus.armhf.yml -p prometheus up -d`

## Grafana
- `docker-compose -f stack-grafana.yml -p grafana up -d`

## Deploy NextCloud
- `docker-compose -f stack-nextcloud.yml -p nextcloud up -d`
- `docker-compose -f stack-nextcloud-cron.yml -p nextcloud_cron up -d`
