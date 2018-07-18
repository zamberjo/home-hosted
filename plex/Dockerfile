ARG ARCH=linuxserver
FROM ${ARCH}/plex

# Dependencies
RUN apk -U upgrade \
    && apk add --no-cache --virtual .build-deps -t \
        locales \
    && apk add --no-cache --virtual .build-deps \
        build-base \
        wget \
        ca-certificates \
    && mv /tmp/config.js /usr/src/app/config.js \
    && cd /usr/src/app \
    && npm install && npm cache clean --force \
    && npm run build \
    && rm -rf /var/cache/apk/* /tmp/* \
    && apk del --force \
        .build-deps

# Setup locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen \
 && locale-gen

# Download/extract Plex ALPINE-ARMV7
ENV PLEX_VERSION=1.11.0.4666-fc63598ba PLEX_PATH=/opt/plex/Application
RUN mkdir -p ${PLEX_PATH} /tmp/plex \
 && cd ${PLEX_PATH} \
 && wget --no-verbose -O /tmp/plex/plex.tar https://downloads.plex.tv/plex-media-server/${PLEX_VERSION}/PlexMediaServer-${PLEX_VERSION}-arm7.spk \
 && tar -xvf /tmp/plex/plex.tar -C /tmp/plex \
 && tar -xvf /tmp/plex/package.tgz -C ${PLEX_PATH} \
 && rm -rf /tmp/plex

# Setup volumes
#  - /config holds the server settings
#  - /data is where media should be mounted
VOLUME ["/config", "/data"]

# Plex config environment vars
ENV HOME=/config

# Plex server port
EXPOSE 32400

WORKDIR ${PLEX_PATH}
RUN mv Resources/start.sh .

# Add a line to the Plex start.sh script to remove any
# previous pid file found in the config dir. Plex wont
# start if this file is left over from a previous run.
RUN sed -i '2i rm -rf /config/Library/Application\\ Support/Plex\\ Media\\ Server/plexmediaserver.pid' ${PLEX_PATH}/start.sh

CMD ["bash", "start.sh"]
