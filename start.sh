#!/bin/bash

echo "root:${RDP_PASSWORD:-changeme}" | chpasswd

service dbus start
pulseaudio --system --disallow-exit --disable-shm &
service xrdp start

echo "[*] Starting Pinggy tunnel..."
while true; do
    ssh -p 443 \
        -o StrictHostKeyChecking=no \
        -o ServerAliveInterval=30 \
        -o ExitOnForwardFailure=yes \
        -R 0:127.0.0.1:3389 \
        tcp@free.pinggy.io
    echo "[*] Tunnel dropped, reconnecting in 5s..."
    sleep 5
done &

tail -f /var/log/xrdp-sesman.log
