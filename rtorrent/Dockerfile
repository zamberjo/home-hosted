FROM alpine:3.8

ENV RT_UID=${RT_UID:-1000} \
    RT_GID=${RT_GID:-1000}

RUN addgroup -g $RT_GID rtorrent && \
    adduser -S -u $RT_UID -G rtorrent rtorrent && \
    apk add --no-cache rtorrent && \
    mkdir -p /data/config.d && \
    mkdir /data/session && \
    mkdir /data/downloads && \
    mkdir /data/watch && \
    chown -R rtorrent:rtorrent /data

COPY --chown=rtorrent:rtorrent config.d/ /data/config.d/
COPY --chown=rtorrent:rtorrent .rtorrent.rc /data/

VOLUME /data/.session

EXPOSE 16891
EXPOSE 6881
EXPOSE 6881/udp
EXPOSE 50000

USER rtorrent

CMD ["rtorrent"]
