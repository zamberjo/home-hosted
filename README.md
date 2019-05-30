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


## Deploy rTorrent + Flood + radarr + sonarr + jackett
- `mkdir -pv $HOME/{downloads,watch,incoming,radarr,sonarr}`
- `mkdir -pv $HOME/jackett/{config,blackhole}`
- `# docker volume create --name rtorrent-incoming-volume -d local -o o=bind -o type=none -o device=$HOME/incoming`
- `docker volume create --name rtorrent-downloads-volume -d local -o o=bind -o type=none -o device=$HOME/downloads`
- `docker volume create --name rtorrent-watch-volume -d local -o o=bind -o type=none -o device=$HOME/watch`
- `docker volume create --name radarr-volume -d local -o o=bind -o type=none -o device=$HOME/radarr`
- `docker volume create --name sonarr-volume -d local -o o=bind -o type=none -o device=$HOME/sonarr`
- `docker volume create --name jackett-blackhole-volume -d local -o o=bind -o type=none -o device=$HOME/jackett/blackhole`
- `docker volume create --name jackett-config-volume -d local -o o=bind -o type=none -o device=$HOME/jackett/config`
- `docker-compose -f stack-rtorrent.yml -p rtorrent up -d`
- *ARM*: `docker-compose -f stack-rtorrent.yml -f stack-rtorrent.armv8.yml -p rtorrent up -d`
- *DEVEL*: `docker-compose -f stack-rtorrent.yml -f stack-rtorrent.devel.yml -p rtorrent up -d`
- *USE*: `tvshows` and `movies` tags
- *FRONTENDS*:
  - https://flood.${DOMAIN}
  - https://couchpotato.${DOMAIN}
  - localhost:9117/UI/Dashboard


## Deploy Plex
- `mkdir -pv $HOME/plex/config`
- `docker volume create --name plex-config-volume -d local -o o=bind -o type=none -o device=$HOME/plex/config`
- `docker-compose -f stack-plex.yml -p plex up -d`
- *ARM*: `docker-compose -f stack-plex.yml -f stack-plex.armv8.yml -p plex up -d`
- *DEVEL*: `docker-compose -f stack-plex.yml -f stack-plex.devel.yml -p plex up -d`
- *FRONTEND*:
  - https://plex.${DOMAIN}


## Deploy HomeAssistant
- `mkdir -pv $HOME/homeassistant-config`
- `docker volume create --name homeassistant-config-volume -d local -o o=bind -o type=none -o device=$HOME/homeassistant-config`
- `docker-compose -f stack-homeassistant.yml -p homeassistant up -d`
- *ARM*: `docker-compose -f stack-homeassistant.yml -f stack-homeassistant.armv8.yml -p homeassistant up -d`
- *DEVEL*: `docker-compose -f stack-homeassistant.yml -f stack-homeassistant.devel.yml -p homeassistant up -d`
- *FRONTEND*:
  - https://homeassistant.${DOMAIN}


## Prometheus
- `docker-compose -f stack-prometheus.yml -p prometheus up -d`
- *ARM*: `docker-compose -f stack-prometheus.yml -f stack-prometheus.armv8.yml -p prometheus up -d`
- *FRONTEND*:
  - localhost:9090


## Grafana
- `docker-compose -f stack-grafana.yml -p grafana up -d`
- *FRONTEND*:
  - https://grafana.${DOMAIN}


## Deploy NextCloud
- `docker-compose -f stack-nextcloud.yml -p nextcloud up -d`
- `docker-compose -f stack-nextcloud-cron.yml -p nextcloud_cron up -d`
- *FRONTEND*:
  - https://nextcloud.${DOMAIN}
