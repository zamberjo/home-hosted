#!/bin/sh

echo "Starting lighttpd..."
lighttpd -f /etc/lighttpd/lighttpd.conf

echo "Starting rtorrent..."
su - rtorrent -c "rtorrent"
