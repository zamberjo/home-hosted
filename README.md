# Device
Currently I'm executing all services on [Nvidia Jetson Nano](https://www.nvidia.com/es-es/autonomous-machines/embedded-systems/jetson-nano/)

# Setup
For lazy setup (armv8) only execute:
`./stack-armv8.sh --all`

## Setup Networking
```
docker network create proxy-network
docker network create postgres-network
docker network create redis-network
```


## Deploy PostgreSQL
- *PROD*:`docker-compose -f stack-postgres.yml -p postgres up -d`
- *ARM*: `./stack-armv8.sh --pg`


## Deploy Redis
- *PROD*: `docker-compose -f stack-redis.yml -p redis up -d`
- *ARM*: `./stack-armv8.sh --redis`


## Deploy Traefik
- *PROD*: `docker-compose -f stack-proxy.yml -p proxy up -d`
- *DEVEL*: `docker-compose -f stack-proxy.yml -f stack-proxy.devel.yml -p proxy up -d`
- *ARM*: `./stack-armv8.sh --traefik`


## Deploy rTorrent + Flood + radarr + sonarr + jackett
### Before deploy
```
- mkdir -pv $HOME/{downloads,watch,radarr,sonarr}
- mkdir -pv $HOME/downloads/{movies,tvshows}
- mkdir -pv $HOME/jackett/{config,blackhole}
- docker volume create --name rtorrent-downloads-volume -d local -o o=bind -o type=none -o device=$HOME/downloads
- docker volume create --name rtorrent-watch-volume -d local -o o=bind -o type=none -o device=$HOME/watch
- docker volume create --name radarr-config-volume -d local -o o=bind -o type=none -o device=$HOME/radarr
- docker volume create --name radarr-movies-volume -d local -o o=bind -o type=none -o device=$HOME/downloads/movies
- docker volume create --name sonarr-config-volume -d local -o o=bind -o type=none -o device=$HOME/sonarr
- docker volume create --name sonarr-tvshows-volume -d local -o o=bind -o type=none -o device=$HOME/downloads/tvshows
- docker volume create --name jackett-blackhole-volume -d local -o o=bind -o type=none -o device=$HOME/jackett/blackhole
- docker volume create --name jackett-config-volume -d local -o o=bind -o type=none -o device=$HOME/jackett/config
```
### Deploy
- *ARM*:
  - `./stack-armv8.sh --rtorrent`
  - `docker-compose -f stack-rtorrent.yml -f stack-rtorrent.armv8.yml -p rtorrent up -d`
- *PROD*: `docker-compose -f stack-rtorrent.yml -p rtorrent up -d`
- *DEVEL*: `docker-compose -f stack-rtorrent.yml -f stack-rtorrent.devel.yml -p rtorrent up -d`
### Usage
  - `https://flood.${DOMAIN}`
  - `https://radarr.${DOMAIN}`
  - `https://sonarr.${DOMAIN}`
  - `https://jackett.${DOMAIN}`

## Deploy Plex
### Before deploy
```
- mkdir -pv $HOME/plex/config
- docker volume create --name plex-config-volume -d local -o o=bind -o type=none -o device=$HOME/plex/config
```
### Deploy
- *ARM*:
  - `./stack-armv8.sh --plex`
  - `docker-compose -f stack-plex.yml -f stack-plex.armv8.yml -p plex up -d`
- *PROD*: `docker-compose -f stack-plex.yml -p plex up -d`
- *DEVEL*: `docker-compose -f stack-plex.yml -f stack-plex.devel.yml -p plex up -d`
### Usage
  - https://plex.${DOMAIN}


## Deploy HomeAssistant
### Before deploy
```
- mkdir -pv $HOME/homeassistant-config
- docker volume create --name homeassistant-config-volume -d local -o o=bind -o type=none -o device=$HOME/homeassistant-config
```
### Deploy
- *ARM*:
  - `./stack-armv8.sh --hass`
  - `docker-compose -f stack-homeassistant.yml -f stack-homeassistant.armv8.yml -p homeassistant up -d`
- *PROD*: `docker-compose -f stack-homeassistant.yml -p homeassistant up -d`
- *DEVEL*: `docker-compose -f stack-homeassistant.yml -f stack-homeassistant.devel.yml -p homeassistant up -d`
### Usage
  - https://homeassistant.${DOMAIN}


## Prometheus
- *ARM*:
  - `./stack-armv8.sh --prometheus`
  - `docker-compose -f stack-prometheus.yml -f stack-prometheus.armv8.yml -p prometheus up -d`
- *PROD*: `docker-compose -f stack-prometheus.yml -p prometheus up -d`
### Usage
  - localhost:9090


## Grafana
- *ARM*: `./stack-armv8.sh --grafana`
- *PROD*: `docker-compose -f stack-grafana.yml -p grafana up -d`
### Usage
  - https://grafana.${DOMAIN}


## Deploy NextCloud
- *ARM*: `./stack-armv8.sh --nextcloud`
- *PROD*:
  - `docker-compose -f stack-nextcloud.yml -p nextcloud up -d`
  - `docker-compose -f stack-nextcloud-cron.yml -p nextcloud_cron up -d`
### Usage
  - https://nextcloud.${DOMAIN}
