#!/bin/bash

# Script intended to be run as root.

# Install dependencies

apt install curl -y && apt install cifs-utils -y

# Create directory
mkdir /srv/photoprism && cd /sSrv/photoprism

# Curl compose.yml & .env
curl -O https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-pic/docker-compose.yml
curl -O https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-pic/.env
nano .env

# Set up drive mounts
read -p "Photo server ipv4 address:" IPV4
read -p "Photo server photo share:" PSHARE
read -p "Photo server username:" SMBUSR
read -p "Photo server password:" SMBPW

# Create fstab
cat <<EOF > /etc/fstab
//$IPV4/$PSHARE /mnt/$PSHARE cifs credentials=/etc/.cred,uid=1000,gid=1000 0 0 
EOF

# Create credential file
cat <<EOF > /etc/.cred
username=$SMBUSR
password=$SMBPW
EOF

mkdir /mnt/$PSHARE #create mount for photo share
mount -a #mount drives

# Start containers
docker-compose up -d
