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
