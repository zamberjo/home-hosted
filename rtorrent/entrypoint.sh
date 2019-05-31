#!/bin/bash

echo "Ejecutando lighttpd en background..."
lighttpd -f /etc/lighttpd/lighttpd.conf

echo "Iniciando rtorrent..."
rtorrent
