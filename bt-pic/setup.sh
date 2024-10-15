#!/bin/bash

# Script intended to be run as root.

# Create directory
mkdir /srv/photoprism && cd /srv/photoprism

# Curl compose.yml & .env
curl -O https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-pic/docker-compose.yml
curl -O https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-pic/.env
nano .env

# Set up drive mounts

read -p "Photo server ipv4 address:" IPV4
read -p "Photo server photo share:" PSHARE
read -p "Photo server username:" SMBUSR
read -p "Photo server password:" SMBPW

cat <<EOF > /etc/fstab
//$IPV4/$PSHARE /mnt/$PSHARE cifs credentials=/etc/.smbcredentials,uid=1000,gid=1000 0 0 
EOF

cat <<EOF > /etc/.cred
username=$SMBUSER
password=$SMBPW
EOF

mkdir /mnt/$PSHARE #create mount for photo share


# Start containers
docker-compose up -d
