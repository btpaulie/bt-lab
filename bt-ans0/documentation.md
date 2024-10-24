# Resources

## Background

This config should be reproducible on Ubuntu. 

## Install Ansible 

- [Ubuntu Install](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu)

```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

## SSH Keys

```
ssh-keygen -t rsa -b 4096 -C "loginName"
```

```
