#!/bin/bash

LATEST_VERSION=$(wget -qO- https://api.github.com/repos/gorhill/uBlock/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
wget https://github.com/gorhill/uBlock/releases/download/${LATEST_VERSION}/uBlock0_${LATEST_VERSION}.chromium.zip -O /tmp/ublock.zip
unzip -o /tmp/ublock.zip -d /opt/chromium/extensions
rm /tmp/ublock.zip
