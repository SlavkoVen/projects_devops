#!/bin/bash

set -e

firewall-cmd --permanent --add-port=3000/tcp
firewall-cmd --reload
firewall-cmd --list-all

systemctl daemon-reload
systemctl start grafana-server
systemctl enable grafana-server
systemctl status grafana-server