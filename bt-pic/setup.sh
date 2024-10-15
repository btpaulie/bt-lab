#!/bin/bash

# Script intended to be run as root.

# Functions
DEPEND () {
    apt install curl -y && apt install cifs-utils -y
}

DIRCREATE () {
    mkdir /srv/photoprism && cd /Srv/photoprism
    mkdir /mnt/$PSHARE
    mount -a
}

PULL_FILES () {
    curl -O https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-pic/docker-compose.yml
    curl -O https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-pic/.env
}

SMB_SETUP () {
    read -p "Photo server ipv4 address:" IPV4
    read -p "Photo server photo share:" PSHARE
    read -p "Photo server username:" SMBUSR
    read -p "Photo server password:" SMBPW
    cat <<EOF > /etc/fstab
    //$IPV4/$PSHARE /mnt/$PSHARE cifs credentials=/etc/.cred,uid=1000,gid=1000 0 0
EOF
    cat <<EOF > /etc/.cred
    username=$SMBUSR
    password=$SMBPW
EOF
}

CONTAINER_RUN () {
    cd /srv/photoprism
    docker-compose up -d
    docker stats
}

# Run 
DEPEND #install dependencies
PULL_FILES #curl compose & .env
SMB_SETUP #get server IP, share name, username, password; mount drive in /mnt
DIRCREATE #create photoprism dir, cd to it, create mount, mount
CONTAINER_RUN #run container, load `docker stats`


