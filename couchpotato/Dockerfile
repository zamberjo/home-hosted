FROM python:2.7-stretch

ENV REPO_URL="https://github.com/CouchPotato/CouchPotatoServer" \
    REPO_BUILD="3.0.1"

WORKDIR /app

RUN set -ex \
    && curl -fsSL "${REPO_URL}/archive/build/${REPO_BUILD}.tar.gz" \
        | tar xzf - -C ./ --strip-components 1

EXPOSE 5050

ENTRYPOINT [ "python", "CouchPotato.py" ]

