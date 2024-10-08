#!/bin/bash

# Set default resolution or use environment variable
RESOLUTION=${RESOLUTION:-1920x1080}

# Update uBlock Origin
/home/user/update-ublock.sh

Xvfb :99 -screen 0 $RESOLUTION"x24" &
x11vnc -display :99 -nopw -forever &
/usr/share/novnc/utils/launch.sh --vnc localhost:5900 --listen 6080 &

# Start PulseAudio
pulseaudio --start

# Start Xfce4 session
startxfce4 &

# Wait for Xfce4 to start
sleep 5

# Start KeePassXC in the background
keepassxc &

DISPLAY=:99 chromium     --no-sandbox     --start-maximized     --incognito     --disable-extensions-except=/opt/chromium/extensions/uBlock0.chromium     --load-extension=/opt/chromium/extensions/uBlock0.chromium
