ARG TAG=v2.7.1
ARG IMAGE=prom/prometheus
FROM ${IMAGE}:${TAG}

COPY prometheus.yml /etc/prometheus/
COPY rules.yml /etc/prometheus/
