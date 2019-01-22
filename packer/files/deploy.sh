#!/bin/bash
set -eu

cd ~
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install
touch /etc/systemd/system/puma.service
echo "[Unit]
Description=Puma Service
After=mongod.service

[Service]
Type=simple
WorkingDirectory=/home/op/reddit
ExecStart=/usr/local/bin/puma --dir /home/op/reddit

[Install]
WantedBy=multi-user.target

" >/etc/systemd/system/puma.service
systemctl daemon-reload
systemctl enable puma




