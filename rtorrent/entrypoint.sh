#!/bin/ash
set -euo pipefail
IFS=$'\n\t'

RT_UID=${RT_UID:-1000}
RT_GID=${RT_GID:-1000}

mkdir -pv \
    /data/downloads \
    /data/incoming \
    /data/session \
    /data/watch

chown -R "${RT_UID}:${RT_GID}" \
    /data/downloads \
    /data/incoming \
    /data/session \
    /data/watch

rm -rfv /data/session/rtorrent.lock

chmod o+w /dev/stdout

if ! echo "${RT_PORT_RANGE}" | grep -q '-'; then
    RT_PORT_RANGE="${RT_PORT_RANGE}-${RT_PORT_RANGE}"
    export RT_PORT_RANGE
fi

RT_VARS="$(env | grep ^RT_ | cut -d'=' -f1 | sed 's/^/$/' | tr '\n' ' ')"
envsubst "${RT_VARS}" </etc/rtorrent.rc.template >/etc/rtorrent.rc

if [[ ${#} -eq 0 ]]; then
    exec su-exec "${RT_UID}:${RT_GID}" rtorrent -n -o import=/etc/rtorrent.rc
fi

exec "${@}"