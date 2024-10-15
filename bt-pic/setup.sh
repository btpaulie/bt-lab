#!/bin/bash

# Script intended to be run as root.

# Create directory
mkdir /srv/photoprism && cd /srv/photoprism

# Curl compose.yml & .env
curl -O https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-pic/docker-compose.yml
curl -O https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-pic/.env
nano .env

# Create mount directory
mkdir /mnt/photo

# Edit fstab

read -p "Photo server ipv4 address:" IPV4
read -p "Photo server photo share:" PSHARE

cat eof

# Start containers
docker-compose up -d
