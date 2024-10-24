# Background
This config should be reproducible on Ubuntu. I'm running on 22.04LTS LXCs on Proxmox. Username will be `bt` on all nodes. 

# To-do
- [ ] Remove direct URL links? 
- [ ] Script out management node config
- [ ] 

# Control node setup

## Install Ansible 

- [Ubuntu Install - Ansible Docs](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu)

```bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

## SSH Keys

Set up key-based authentication for SSH between your control and managed node(s). 

```bash
ssh-keygen -t rsa -b 4096 -C "loginName"
```
Example: `ssh-keygen -t rsa 4096 bt@bt-jf1.local`

```bash
ssh-copy-id user@<remote host>
```
Example: `ssh-copy-id bt@bt-jf1`

## Hosts file

Default hosts file will be in `/etc/ansible/hosts`. 

```bash
curl -O https://raw.githubusercontent.com/btpaulie/bt-lab/refs/heads/main/bt-ans0/hosts 
```

```bash
sudo cat hosts > /etc/ansible/hosts
```