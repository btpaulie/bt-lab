Physical node in bt-lab. Dell XPS 15 9560. Runs **Proxmox 8.0.3**.

# Networking

<font color=grey><small>192.168.86.</small></font><font color=yellow>99</font><font color=orange>:8006</font>

| Interface | IP | DNS | 
| --- | --- | --- | 
| `wlp2s0` | - | - | 
| `enx00e04c68065c`  | `192.168.86.99/24` | `192.168.86.1`  |
| `vrbr0` | `192.16.86.100/24` | -  | 


# Resources

| Resource | Spec | 
| --- | --- | 
| CPU | Intel i7-7700HQ 4 core, 8 thread @ 3.800GHz |
| RAM | 32<font color="gray"><small> (16x2)</small></font> GB DDR4-3200 | 
| GPU | NVIDIA GeForceGTX 1050 Mobile | 
| Power Supply | 130W barrel-tip charger | 

## Disks

| Interface | Connection |  Disk | Role |  Size | Encryption | 
| --- | --- | --- | --- | --- | --- | 
| `nvme0n1` | NVME | Toshiba | OS Drive | 1TB | None |   

---

# Notes

## Installation / configuration

### Networking

Proxmox doesn't seem to recognize the USB to Ethernet adapter during the install process, so we need to manually set the adapter's IP to access the web UI. 

First, use `ip` to view available interfaces, find one with a MAC address that matches the adapter's. 

Next, configure the interface: 

```bash
nano /etc/network/interfaces
```

In my case, I wanted it on the same subnet <font color=magenta><small>check terminology!!!</small></font> as the main LAN, so I assigned the following settings:

```yaml
iface enx00e04c68065c inet static
        address 192.168.86.99/24
        netmask 255.255.255.0
        gateway 192.168.86.1
        dns-nameservers 192.168.86.1, 8.8.8.8
```

In `/etc/resolv.conf`, DNS must also be set. 

```yaml
search gustavsen.me
nameserver 192.168.86.1
```

Afterwards, we need to restart networking: 

```bash
systemctl restart networking
```

### Power management

To prevent the laptop from sleeping, edit `logind.conf` 

```bash
nano /etc/systemd/logind.conf
```

Find the line starting with `#HandleLidSwitch=`. Uncomment it, and change it to read 

```yaml
HandleLidSwitch=ignore
```

Restart `logind`

```bash
systemctl restart systemd-logind
```

The laptop lid can now be closed without disrupting connection. 

# Updates, etc. 

See: [Proxmox - Package Repositories](https://pve.proxmox.com/wiki/Package_Repositories)

First order of business is to switch from the Proxmox VE Enterprise (paid) repositories, to the Proxmox VE Community Edition (free) respositories: 

```bash
nano /etc/apt/sources.list
```

Delete the contents of the file, and replace with the following: 

```yml
deb http://ftp.debian.org/debian bookworm main contrib
deb http://ftp.debian.org/debian bookworm-updates main contrib

# Proxmox VE pve-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription

# security updates
deb http://security.debian.org/debian-security bookworm-security main contrib
```

Then, we need to `cd` to `/etc/apt/sources.list.d/` and remove both of the files here: 

```bash
rm <file1>
rm <file2>
```

Now Proxmox won't be searching for enterprise repos. We can upgrade like normal

```bash
apt update -y
apt upgrade -y
```

## Downloading ISOs

Now we need some .ISO to install operating systems on our VMs. We'll use `wget`. The default ISO directory is `/var/lib/vz/template/iso`. In this example, we're downloading the Kali Linux ISO. 

```bash
wget -P /var/lib/vz/template/iso https://cdimage.kali.org/kali-2023.2/kali-linux-2023.2a-installer-amd64.iso
```


