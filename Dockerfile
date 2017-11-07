FROM debian
MAINTAINER Shawn Mix, @1activegeek

# global environment Settings
ENV INSYNC_ADDRESS="cloud.druva.com" \
INSYNC_PORT="443" \
INSYNC_STORAGE="" \
INSYNC_PROFILE="" \
INSYNC_USERNAME="" \
INSYNC_MAIL="" \
INSYNC_TOKEN="" \
INSYNC_DOWNLOAD="https://downloads.druva.com/downloads/inSync/Linux/5.9/druva-insync-client_5.9-51251_amd64.deb" \
USER="druva" \
HOME="/home/druva/"

# update/install packages
RUN \
apt-get update && \
apt-get install -y \
  curl \
  xvfb \
  libfontconfig \
  desktop-file-utils && \

# insync install
curl -o \
  /tmp/insync-client.deb -L \
  ${INSYNC_DOWNLOAD} && \
  dpkg -i /tmp/insync-client.deb && \

# cleanup
apt-get clean && \
apt-get remove -y --purge curl && \
apt autoremove -y && \
rm -rf \
  /tmp/* && \
rm -rf /var/lib/apt/lists/* && \

# add in basic user, and create home directory for INI
useradd --create-home -s /bin/bash druva && \

# create directories for sample/dummy data and change permissions
mkdir /home/druva/Desktop && \
mkdir /home/druva/Downloads && \
mkdir /home/druva/Documents && \
chown -R druva:druva /home/druva

WORKDIR /home/druva
USER druva

# Create mountable volume for backups
VOLUME /home/druva/Desktop /home/druva/Downloads /home/druva/Documents

# launch inSync on run
ENTRYPOINT echo "ADDRESS = '${INSYNC_ADDRESS}:${INSYNC_PORT}'" >> "/home/druva/Downloads/inSyncConfig.ini" && \
echo "STORAGE = '${INSYNC_STORAGE}'" >> "/home/druva/Downloads/inSyncConfig.ini" && \
echo "PROFILE = '${INSYNC_PROFILE}'" >> "/home/druva/Downloads/inSyncConfig.ini" && \
echo "USERNAME = '${INSYNC_USERNAME}'" >> "/home/druva/Downloads/inSyncConfig.ini" && \
echo "MAIL = '${INSYNC_MAIL}'" >> "/home/druva/Downloads/inSyncConfig.ini" && \
echo "TOKEN = '${INSYNC_TOKEN}'" >> "/home/druva/Downloads/inSyncConfig.ini" && \
xvfb-run -a inSync
