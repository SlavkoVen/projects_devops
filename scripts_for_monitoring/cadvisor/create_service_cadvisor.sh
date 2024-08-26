cat << EOF > /etc/systemd/system/cadvisor.service
[Unit]
Description=Cadvisor exporter
After=network.target

[Service]
User=root
ExecStart=/bin/bash -c '/usr/local/bin/cadvisor'
ExecReload=/bin/kill -HUP $MAINPID

NoNewPrivileges=true
ProtectHome=true
ProtectSystem=full
  
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start cadvisor
systemctl enable cadvisor
systemctl status cadvisor
