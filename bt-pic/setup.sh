#!/bin/bash

# Script intended to be run as root.

# Functions

DEPEND () {
    apt install curl -y && apt install cifs-utils -y
}

DIRCREATE () {
    mkdir /srv/photoprism && cd /Srv/photoprism
}

PULL_FILES () {
    curl -O https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-pic/docker-compose.yml
    curl -O https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-pic/.env
}

SMB_MOUNT () {
    read -p "Photo server ipv4 address:" IPV4
    read -p "Photo server photo share:" PSHARE
    read -p "Photo server username:" SMBUSR
    read -p "Photo server password:" SMBPW
    cat <<EOF > /etc/fstab
    //$IPV4/$PSHARE /mnt/$PSHARE cifs credentials=/etc/.cred,uid=1000,gid=1000 0 0 
    EOF
}

# Run 
DEPEND #install dependencies
DIRCREATE #create photoprism dir, cd to it
PULL_FILES #curl compose & .env


# Set up drive mounts

# Edit fstab


# Create credential file
cat <<EOF > /etc/.cred
username=$SMBUSR
password=$SMBPW
EOF

mkdir /mnt/$PSHARE #create mount for photo share
mount -a #mount drives

# Start containers
docker-compose up -d

