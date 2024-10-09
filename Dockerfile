FROM debian:bullseye-slim

ARG CACHEBUST=1

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y     chromium     xfce4     xfce4-goodies     xvfb     x11vnc     novnc     wget     unzip     pulseaudio     pavucontrol     vlc     keepassxc     && apt-get clean     && rm -rf /var/lib/apt/lists/*

# Install uBlock Origin
RUN mkdir -p /opt/chromium/extensions     && wget https://github.com/gorhill/uBlock/releases/download/1.42.4/uBlock0_1.42.4.chromium.zip -O /tmp/ublock.zip     && unzip /tmp/ublock.zip -d /opt/chromium/extensions     && rm /tmp/ublock.zip

# Set up a non-root user
RUN useradd -m user
USER user
WORKDIR /home/user

# Create directories
RUN mkdir -p /home/user/keepass /home/user/Downloads

COPY start-environment.sh /home/user/start-environment.sh
COPY update-ublock.sh /home/user/update-ublock.sh

EXPOSE 6080 4713

CMD ["/home/user/start-environment.sh"]
