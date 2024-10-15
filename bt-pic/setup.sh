#!/bin/bash

mkdir /srv/photoprism
cd /srv/photoprism
curl -O https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-pic/docker-compose.yml
curl -O https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-pic/.env
nano .env
docker-compose up -d
