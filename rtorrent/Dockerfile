FROM alpine:3.8

RUN set -ex \
    && apk add --no-cache \
        gettext \
        rtorrent \
        su-exec

COPY rtorrent.rc.template /etc/
COPY entrypoint.sh /usr/local/bin/

ENV RT_UID=1000 \
    RT_GID=1000

ENV RT_CHECK_HASH=yes \
    RT_DHT=disable \
    RT_DHT_PORT=6881 \
    RT_DOWNLOAD_RATE=0 \
    RT_UPLOAD_RATE=200 \
    RT_ENCODING=utf8 \
    RT_LOG_LEVEL=info \
    RT_LOW_DISKSPACE=1000GB \
    RT_MAX_CONN=50 \
    RT_MAX_OPEN_FILES=600 \
    RT_MAX_OPEN_SOCKETS=300 \
    RT_MAX_DOWNLOADS_GLOBAL=10 \
    RT_MAX_MEM_USAGE=1800M \
    RT_MAX_PEERS=62 \
    RT_MAX_PEERS_SEED=80 \
    RT_MAX_UPLOADS=10 \
    RT_MAX_UPLOADS_GLOBAL=20 \
    RT_MIN_PEERS=20 \
    RT_MIN_PEERS_SEED=60 \
    RT_PEER_EXCHANGE=no \
    RT_PEERS_DESIRED=80 \
    RT_PORT_RANDOM=no \
    RT_PORT_RANGE=6890-6890 \
    RT_RATIO=enable \
    RT_RATIO_MAX=2000 \
    RT_RATIO_MIN=400 \
    RT_RATIO_UPLOAD=200M \
    RT_UMASK=0027

WORKDIR /data

VOLUME /data/incoming
VOLUME /data/session
VOLUME /data/downloads
# VOLUME /data/watch

EXPOSE 5000 ${RT_PORT_RANGE} ${RT_DHT_PORT}/udp

ENTRYPOINT ["entrypoint.sh"]

CMD []
