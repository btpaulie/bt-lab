#!/bin/bash

# Script intended to be run as root.

# Functions
DEPEND () {
    apt install curl -y && apt install cifs-utils -y
}

GET_VAR () {
    read -p "Photo server ipv4 address:" IPV4
    read -p "Photo server photo share:" PSHARE
    read -p "Photo server username:" SMBUSR
    read -p "Photo server password:" SMBPW
}

DIR_PULL () {
    mkdir /srv/photoprism
    mkdir /mnt/$PSHARE
    cd /srv/photoprism
    curl -O https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-pic/docker-compose.yml
    curl -O https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-pic/.env
}

SMB_SETUP () {
    cat <<EOF > /etc/fstab
    //$IPV4/$PSHARE /mnt/$PSHARE cifs credentials=/etc/.cred,uid=1000,gid=1000 0 0
EOF
    cat <<EOF > /etc/.cred
    username=$SMBUSR
    password=$SMBPW
EOF
    mount -a
}

CONTAINER_RUN () {
    cd /srv/photoprism
    docker-compose up -d
    docker stats
}

# Run 
DEPEND #install dependencies
GET_VAR #get variables from user
DIR_PULL #make directories, curl compose & .env
SMB_SETUP #edit fstab, edit credential file, mount drives
CONTAINER_RUN #run container, load `docker stats`


