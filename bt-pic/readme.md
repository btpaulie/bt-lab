# bt-pic - Photoprism server

# Overview

Installation script, compose, etc. for photoprism server.

# Install

For Ubuntu: 

```bash
wget -O https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-pic/setup.sh
```

## .env variables
 
The `.env` file has the following variables: `DB_USER`, `DB_PW`, `DB_ROOT`, `PP_ADMIN`, `PP_PW`. The install script will drop you into nano to edit. Example file: 

```
DB_USER=photouser
DB_PW=photopass
DB_ROOT=rootpass
...
```
>[!note]
>Set proper security on this file

## About compose.yml



# To-do

- [ ] Use user-input instead of nano to set variables
- [ ] 
