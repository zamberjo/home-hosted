FROM alpine:3.8

ENV RT_UID=${RT_UID:-1000} \
    RT_GID=${RT_GID:-1000}

RUN addgroup -g $RT_GID rtorrent && \
    adduser -S -u $RT_UID -G rtorrent rtorrent && \
    apk add --no-cache rtorrent lighttpd && \
    mkdir -p /home/rtorrent/rtorrent/config.d && \
    mkdir /home/rtorrent/rtorrent/.session && \
    mkdir /home/rtorrent/rtorrent/download && \
    mkdir /home/rtorrent/rtorrent/watch && \
    chown -R rtorrent:rtorrent /home/rtorrent/rtorrent

COPY lighttpd.conf /tmp/
RUN cat /tmp/lighttpd.conf >> /etc/lighttpd/lighttpd.conf
RUN sed -i 's/\(server.username\s*=\s\).*/\1"rtorrent"/g' /etc/lighttpd/lighttpd.conf
RUN sed -i 's/\(server.groupname\s*=\s\).*/\1"rtorrent"/g' /etc/lighttpd/lighttpd.conf
RUN sed -i 's/\(server.pid-file\s*=\s\).*/\1"\/home\/rtorrent\/lighttpd.pid"/g' /etc/lighttpd/lighttpd.conf
RUN chown -R rtorrent. /etc/lighttpd/lighttpd.conf

COPY --chown=rtorrent:rtorrent entrypoint.sh /entrypoint.sh
RUN chmod a+x entrypoint.sh
RUN chown -R rtorrent:rtorrent /var/log/lighttpd

COPY --chown=rtorrent:rtorrent config.d/ /home/rtorrent/rtorrent/config.d/
COPY --chown=rtorrent:rtorrent .rtorrent.rc /home/rtorrent/

VOLUME /home/rtorrent/rtorrent/.session

EXPOSE 80
EXPOSE 16891
EXPOSE 6881
EXPOSE 6881/udp
EXPOSE 50000

USER rtorrent

RUN touch /home/rtorrent/lighttpd.pid

# ENTRYPOINT ["/entrypoint.sh"]
CMD ["rtorrent"]
