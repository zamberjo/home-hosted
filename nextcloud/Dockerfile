ARG TAG=15.0.5-apache
FROM nextcloud:${TAG}

# https://nextcloud.com/blog/setup-cron-or-systemd-timers-for-the-nextcloud-preview-generator
# https://apps.nextcloud.com/apps/previewgenerator
RUN set -ex \
    && echo '0 4 * * * php -f /var/www/html/occ preview:pre-generate' \
        >> /var/spool/cron/crontabs/www-data

COPY *.config.php /usr/src/nextcloud/config/
