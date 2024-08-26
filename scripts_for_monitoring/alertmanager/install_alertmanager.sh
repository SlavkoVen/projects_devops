#!/bin/bash

set -e

wget https://github.com/prometheus/alertmanager/releases/download/v0.25.0/alertmanager-0.25.0.linux-amd64.tar.gz
tar xf alertmanager-0.25.0.linux-amd64.tar.gz
cd alertmanager-0.25.0.linux-amd64
cp alertmanager /usr/local/bin
mkdir -p /etc/alertmanager /var/lib/alertmanager
cp alertmanager.yml /etc/alertmanager
useradd --no-create-home --home-dir / --shell /bin/false alertmanager
chown -R alertmanager:alertmanager /var/lib/alertmanager
