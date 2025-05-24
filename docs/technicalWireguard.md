# Wireguard installation notes

- To load and verify wireguard linux kernel module: `modprobe wireguard`; `lsmod | grep wireguard`
- To load permanently: `sudo echo 'wireguard' >> /etc/modules`
- Install wireguard tools: `apt install wireguard-tools`
- Generate server key, save and secure: `wg genkey | sudo tee /etc/wireguard/server.key`; `chmod 0400 /etc/wireguard/server.key`
- Public key: `cat /etc/wireguard/server.key | wg pubkey | sudo tee /etc/wireguard/server.pub`

mkdir -p /etc/wireguard/clients

wg genkey | tee /etc/wireguard/clients/client1.key

cat /etc/wireguard/clients/client1.key | wg pubkey | tee /etc/wireguard/clients/client1.pub

/etc/wireguard/wg0.conf

```conf
[Interface]
PrivateKey = <>
Address = 192.168.0.104/29
ListenPort = 51820
SaveConfig = true
[Peer]
PublicKey = <>
AllowedIPs = 192.168.0.1/24
```

- Only required for egress from vpn server: `/etc/sysctl.conf`: uncomment `net.ipv4.ip_forward=1`; Apply: `sysctl -p`
ip route list default

```log
  Logical volume "vm-1000-disk-0" created.
Creating filesystem with 2097152 4k blocks and 524288 inodes
Filesystem UUID: d87d616b-6c98-4786-aaa4-140bb5b96306
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632
extracting archive '/var/lib/vz/template/cache/debian-12-turnkey-wireguard_18.2-1_amd64.tar.gz'
Total bytes read: 565329920 (540MiB, 59MiB/s)
Detected container architecture: amd64
Creating SSH host key 'ssh_host_ed25519_key' - this may take some time ...
done: SHA256:JpTMX13wIcZd44vMAJqtuzoxQq+6FytSK50mY7Z59oY root@wireguard
Creating SSH host key 'ssh_host_rsa_key' - this may take some time ...
done: SHA256:grdAGGpsGVWHK4vilLQVpjXPHDk5ZjxFK0U8/xtS+j8 root@wireguard
Creating SSH host key 'ssh_host_dsa_key' - this may take some time ...
done: SHA256:7vOHoISjtwQ5ScJW2e+7DtS2jDtVXlx+l99iH8bzReY root@wireguard
Creating SSH host key 'ssh_host_ecdsa_key' - this may take some time ...
done: SHA256:oRvPn8yjX7ztPYsYRXqOpayXtJCvGUrtlqgkNEw2l9g root@wireguard
TASK OK
```