#!/bin/bash

set -e

wget https://github.com/prometheus/prometheus/releases/download/v2.41.0/prometheus-2.41.0.linux-amd64.tar.gz
tar xf prometheus-2.41.0.linux-amd64.tar.gz

cd prometheus-2.41.0.linux-amd64
cp prometheus promtool /usr/local/bin
mkdir -p /etc/prometheus /var/lib/prometheus
cp prometheus.yml /etc/prometheus
useradd --no-create-home --home-dir / --shell /bin/false prometheus
chown -R prometheus:prometheus /var/lib/prometheus
