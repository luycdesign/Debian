#!/bin/bash

service dbus start
pulseaudio --start --system --disallow-exit --disable-shm
service xrdp start

mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

echo "[*] Starting Pinggy tunnel..."
ssh -p 443 \
    -o StrictHostKeyChecking=no \
    -o ServerAliveInterval=30 \
    -o ExitOnForwardFailure=yes \
    -R 0:127.0.0.1:3389 \
    tcp@free.pinggy.io &

tail -f /var/log/xrdp-sesman.log
