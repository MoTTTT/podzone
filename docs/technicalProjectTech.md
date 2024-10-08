# ProjectTech

## Domain registration, and email mailboxes

- Using PorkBun as registrar
- Domain purchased: `littlecanton.one`
- Email hosting: `contact@littlecanton.one`
- Email hosting: `reservations@littlecanton.one`
- Total costs: £1.57 (1 yr domain) + £24 (1 yr X 2 email addresses) = £25.57

## Infrastructure build

- Rack server - mercury: Dell PowerEdge R720, 32 threads, 112GB RAM, 4.8TB Storage
- 4 X t630 - norham01-norham04: 4 CPU; 24GB RAM; 128GB + 128GB Storage: £200
- 1 X t630 - habilis: 4 CPU; 24GB RAM; 128GB Storage; M.2 WiFi module: £70
- Build habilis: Ubuntu serve, set up as gateway to ethernet port, squid proxy, reverse-proxy port forwarding
- Build rack server and remainder of t730s: Install hypervisor
- Create ceph cluster on ProxMox t630s, add disks, add a ceph monitor on mercury
- Build VMs for k8s cluster
- Build out k8s cluster, and connect to distributed storage
- Bootstrap k8s cluster with flux
- Deploy Radio Station, WordPress instances and content server to k8s cluster
- Build LXC NextCloud appliance
- Build LXC Network file server
- Build VM or LXC for Project Management software

| Hostname   | Machine | Threads | RAM    | Storage | Role                     |
|------------|---------|---------|--------|---------|--------------------------|
| jiaotu     | R720    | 32      | 64 GB  | 4.8TB   | ProxMox VM and LXC host  |
| habilis    | t730    | 4       | 24 GB  | 128 GB  | Gateway                  |
| norham01-4 | t730    | 4       | 24 GB  | 128 GB  | ProxMox Ceph node        |

### Infrastructure costing

| Host       | Component   | Unit Cost | Quantity    | Total   | Notes                            |
|------------|-------------|-----------|-------------|---------|----------------------------------|
| jiaotu     | R720        | £ 88      | 1           | £ 88    | 2x Xeon CPU No RAM 2x 600gb Hdd  |
| jiaotu     | RAM         | £ 6       | 14          | £ 84    | 14 X 8 GB DDR3 Server RAM        |
| jiaotu     | Caddies     | £ 5       | 6           | £ 30    | 6 X SFF SAS HDD caddies          |
| jiaotu     | Drive 147GB | £ 8       | 4           | £ 32    | 4 X 147GB SAS HDD                |
| jiaotu     | Drive 600GB | £ 10      | 2           | £ 20    | 2 X 600GB SAS HDD                |
| jiaotu     | Total       |           |             | £254    | 112GB RAM, 4.8TB Storage         |
| norham0X   | t630        | £ 50      | 4           | £200    | 24GB RAM; 128GB + 128GB Storage  |

- Multiplug
- Network cables

## Hostnames for littlecanton.one

- Hostnames mercury and habilis assigned, ProxMox t630s need names to replace norhamXX
- Theme: Nine sons of the Dragon: <https://en.wikipedia.org/wiki/Nine_sons_of_the_dragon>
- Converted to nearest UK keyboard characters, and assigned IPs

```hosts
# /etc/hosts file for littlecanton.one network
192.168.3.1   bian        # t630 gateway
192.168.3.21  chaofeng    # t630 proxmox
192.168.3.22  chiwen      # t630 proxmox
192.168.3.23  bixi        # t630 proxmox
192.168.3.24  pulao       # t630 jump
192.168.3.10  jiaotu      # R720 proxmox
# 192.168.3.    taotie    # Unassigned
# 192.168.3.    qiuniu    # Unassigned
# 192.168.3.    yazi      # Unassigned
# 192.168.3.    suanni    # Unassigned
```

### Other hardware

- [X] Network switch
- [X] Network cabling
- [X] Multiplug
- [X] Kettle plug leads
- [X] 2TB nVME M.4 SSDs
- [X] PCIe nVME M.4 SSD adapter

## habilis

### habilis: Installations

- [X] OS: Ubuntu server 22.04; Connect to router via wifi; set static IP on ethernet to `192.168.3.1/24`
- [X] Install Internet Proxy: `sudo apt-get install squid`
- [X] Ip Forwarding: uncomment `#net.ipv4.ip_forward=1` in `/etc/sysctl.conf`
- [X] Persistence for iptables rules: `sudo apt install iptables-persistent`
- [X] Reverse-proxy: `sudo apt install apache2`
- [X] Reverse-proxy modules: `sudo a2enmod ssl proxy proxy_html proxy_http proxy_wstunnel rewrite`
- [X] Let's encryt certbot: `sudo snap install --classic certbot`
- [X] kubectl: `sudo snap install kubectl --classic`
- [X] k9s: `sudo snap install k9s`; link binary `sudo ln -s /snap/k9s/current/bin/k9s /usr/bin/k9s`

### habilis: Configuration

- [X] IP Tables: NAT for gateway; `sudo iptables -t nat -A POSTROUTING -s 192.168.3.0/24 -o wlp2s0 -j MASQUERADE`
- [X] Port forwarding for ProxMox: `iptables -t nat -A PREROUTING -i wlp2s0 -p tcp --dport 8006 -j DNAT --to-destination 192.168.2.10:8006`
- [X] Port forwarding for IceCast:
- [X] View: `sudo iptables -t nat -nvL --line-numbers`
- [X] Persist: `sudo iptables-save > /etc/iptables/rules.v4`
- [ ] Reverse proxy
- [ ] Configure certbot: `sudo certbot --apache`

### habilis: Other services

- [ ] VPN <https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-an-openvpn-server-on-ubuntu-22-04>
- [ ] CA: <https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-on-ubuntu-22-04>
- [ ] Mail Server: <https://mailinabox.email/>

## host configurations

- `setproxy.sh`

```bash
#!/bin/bash
# setproxy.sh

cat <<EOF > /etc/environment
https_proxy=http://192.168.3.1:3128
http_proxy=http://192.168.3.1:3128
ftp_proxy=ftp://192.168.3.1:3128
no_proxy=10.0.0.0/8,192.168.0.0/16,127.0.0.1,172.16.0.0/16,.svc,localhost
EOF

cat <<EOF >> /etc/bash.bashrc
export https_proxy=http://192.168.3.1:3128
export http_proxy=http://192.168.3.1:3128
export ftp_proxy=ftp://192.168.3.1:3128
export no_proxy=10.0.0.0/8,192.168.0.0/16,127.0.0.1,172.16.0.0/16,.svc,localhost
EOF

cat <<EOF >> /etc/apt/apt.conf
Acquire::http::proxy  "http://192.168.3.1:3128/";
Acquire::ftp::proxy "ftp://192.168.3.1:3128/";
Acquire::https::proxy "http://192.168.3.1:3128/";
EOF
```


### ProxMox

- [ ] ProxMox install
- [ ] Post installation scripts: <https://tteck.github.io/Proxmox/>
- [ ] Proxmox configure
- [ ] Link nodes
- [ ] Install ceph - via ProxMox gui
- [ ] Assign disks to ceph

### Application build-out

- [ ] k8s cluster
- [ ] NextCloud container, with disks assigned
- [ ] NextCloud: <https://docs.nextcloud.com/server/latest/admin_manual/maintenance/backup.html>


## k8s: Cluster storage options

- [ ] Ceph
- [ ] OpenEBS: <https://openebs.io/>
- [ ] LongHorn: <https://longhorn.io/>


### iSCSI

- [ ] Cluster storage: <https://pve.proxmox.com/pve-docs/pve-admin-guide.html#storage_open_iscsi>
- [ ] Cluster storage: <https://pve.proxmox.com/wiki/ISCSI_Multipath>

