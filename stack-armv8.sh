#!/bin/bash

ARG_PG=0
ARG_REDIS=0
ARG_TRAEFIK=0
ARG_RTORRENT=0
ARG_PLEX=0
ARG_HASS=0
ARG_PROMETHEUS=0
ARG_GRAFANA=0
ARG_NEXTCLOUD=0
ARG_ALL=0
PRINT_HELP=1

print_help () {
    >&2 cat <<EOF
Usage:
  ./stack-arm64 [ARGS]
Arguments:
  --pg            Force build PostgreSQL stack.
  --redis         Force build Redis stack.
  --traefik       Force build Traefik stack.
  --rtorrent      Force build Rtorrent + Flood + Couchpotato + Jckett stack.
  --plex          Force build Plex stack.
  --hass          Force build Homeassistant stack.
  --prometheus    Force build Prometheus stack.
  --grafana       Force build Grafana stack.
  --nextcloud     Force build Nextcloud stack.
  --all           Force build all stacks.
Examples:
  ./stack-arm64 --all
  ./stack-arm64 --traefik
  ./stack-arm64 --prometheus --grafana
  ./stack-arm64 --nextcloud --pg --redis
EOF
    exit 1
}

while [[ ${#} -gt 0 ]]; do
    case "${1}" in
        --pg)
            ARG_PG=1
            PRINT_HELP=0
            ;;
        --redis)
            ARG_REDIS=1
            PRINT_HELP=0
            ;;
        --traefik)
            ARG_TRAEFIK=1
            PRINT_HELP=0
            ;;
        --rtorrent)
            ARG_RTORRENT=1
            PRINT_HELP=0
            ;;
        --plex)
            ARG_PLEX=1
            PRINT_HELP=0
            ;;
        --hass)
            ARG_HASS=1
            PRINT_HELP=0
            ;;
        --prometheus)
            ARG_PROMETHEUS=1
            PRINT_HELP=0
            ;;
        --grafana)
            ARG_GRAFANA=1
            PRINT_HELP=0
            ;;
        --nextcloud)
            ARG_NEXTCLOUD=1
            PRINT_HELP=0
            ;;
        --all)
            ARG_ALL=1
            PRINT_HELP=0
            ;;
        --help)
            print_help
            ;;
        *)
            >&2 echo "[ERROR] unknown arg: ${1}"
            exit 1
            ;;
    esac
    shift
done

[[ ${PRINT_HELP} -eq 1 ]] && print_help

if [[ ${ARG_PG} -eq 1 || ${ARG_ALL} -eq 1 ]]; then
    docker inspect postgres-network &> /dev/null || docker network create postgres-network;
    docker-compose \
        -f stack-postgres.yml \
        -p postgres \
        up -d --build --force-recreate
fi

if [[ ${ARG_REDIS} -eq 1 || ${ARG_ALL} -eq 1 ]]; then
    docker inspect redis-network &> /dev/null || docker network create redis-network;
    docker-compose \
        -f stack-redis.yml \
        -p redis \
        up -d --build --force-recreate
fi

if [[ ${ARG_TRAEFIK} -eq 1 || ${ARG_ALL} -eq 1 ]]; then
    docker inspect proxy-network &> /dev/null || docker network create proxy-network;
    docker-compose \
        -f stack-proxy.yml \
        -p proxy \
        up -d --build --force-recreate
fi

if [[ ${ARG_RTORRENT} -eq 1 || ${ARG_ALL} -eq 1 ]]; then
    docker inspect rtorrent-incoming-volume &> /dev/null
    if [[ $? -eq 1 ]]; then
        >&2 echo "[ERROR] Before build, you must create rtorrent-incoming-volume volume!"
        exit 1
    fi
    docker inspect rtorrent-downloads-volume &> /dev/null
    if [[ $? -eq 1 ]]; then
        >&2 echo "[ERROR] Before build, you must create rtorrent-downloads-volume volume!"
        exit 1
    fi
    docker inspect rtorrent-watch-volume &> /dev/null
    if [[ $? -eq 1 ]]; then
        >&2 echo "[ERROR] Before build, you must create rtorrent-watch-volume volume!"
        exit 1
    fi
    # docker inspect couchpotato-volume &> /dev/null
    # if [[ $? -eq 1 ]]; then
    #     >&2 echo "[ERROR] Before build, you must create couchpotato-volume volume!"
    #     exit 1
    # fi
    docker inspect jackett-blackhole-volume &> /dev/null
    if [[ $? -eq 1 ]]; then
        >&2 echo "[ERROR] Before build, you must create jackett-blackhole-volume volume!"
        exit 1
    fi
    docker inspect jackett-config-volume &> /dev/null
    if [[ $? -eq 1 ]]; then
        >&2 echo "[ERROR] Before build, you must create jackett-config-volume volume!"
        exit 1
    fi
    docker-compose \
        -f stack-rtorrent.yml \
        -f stack-rtorrent.armv8.yml \
        -p rtorrent \
        up -d --build --force-recreate
fi

if [[ ${ARG_PLEX} -eq 1 || ${ARG_ALL} -eq 1 ]]; then
    docker inspect plex-config-volume &> /dev/null
    if [[ $? -eq 1 ]]; then
        >&2 echo "[ERROR] Before build, you must create plex-config-volume volume!"
        exit 1
    fi
    docker-compose \
        -f stack-plex.yml \
        -f stack-plex.armv8.yml \
        -p plex \
        up -d --build --force-recreate
fi

if [[ ${ARG_HASS} -eq 1 || ${ARG_ALL} -eq 1 ]]; then
    docker inspect homeassistant-config-volume &> /dev/null
    if [[ $? -eq 1 ]]; then
        >&2 echo "[ERROR] Before build, you must create homeassistant-config-volume volume!"
        exit 1
    fi
    docker-compose \
        -f stack-homeassistant.yml \
        -f stack-homeassistant.armv8.yml \
        -p homeassistant \
        up -d --build --force-recreate
fi

if [[ ${ARG_PROMETHEUS} -eq 1 || ${ARG_ALL} -eq 1 ]]; then
    docker-compose \
        -f stack-prometheus.yml \
        -f stack-prometheus.armv8.yml \
        -p prometheus \
        up -d --build --force-recreate
fi

if [[ ${ARG_GRAFANA} -eq 1 || ${ARG_ALL} -eq 1 ]]; then
    docker-compose \
        -f stack-grafana.yml \
        -p grafana \
        up -d --build --force-recreate
fi

if [[ ${ARG_NEXTCLOUD} -eq 1 || ${ARG_ALL} -eq 1 ]]; then
    docker-compose \
        -f stack-nextcloud.yml \
        -p nextcloud \
        up -d --build --force-recreate
    docker-compose \
        -f stack-nextcloud-cron.yml \
        -p nextcloud_cron \
        up -d --build --force-recreate
fi
