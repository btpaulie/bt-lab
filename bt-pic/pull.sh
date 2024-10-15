#!/bin/bash

mkdir /srv/photoprism
cd /srv/photoprism
wget https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-pic/docker-compose.yml
wget https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-pic/photoprism.env
echo "Remember to fill in your .env file variables before running the compose."
nano photoprism.env
docker-compose up -d
