# Reverse proxy

The northern site needed to be issued with a static IP address from the ISP.

With one cluster on site, this IP address would have port forwarding configured on the router, to send http and https traffic to the metallb L2 load balancer.

However, since more than on cluster will be served on the same IP address, a front-end proxy is installed on a t520.

## Certbot

In order to reverse proxy to the https endpoints in the cluster, we need to terminate ssl for all hosts supported. LetsEncryp's Certbot is used.

## Northern request routing

```mermaid
---
title: northern.podzone.net Request routing
---
graph TD

Internet --145.40.190.159  --> router
router -- 80\n443 --> dmz
router -- 8001\n8002 --> metallb3
dmz -- 192.168.1.220 --> metallb1
dmz -- 192.168.1.222 --> metallb2
dmz -- 192.168.1.221 --> metallb3

metallb1 --> k8s01
metallb1 --> k8s02
metallb1 --> k8s03
metallb2 --> k8s04
metallb2 --> k8s05
metallb2 --> k8s06
metallb3 --> k8s07
metallb3 --> k8s08
metallb3 --> k8s09
metallb3 --> k8s10

metallb1[[prod]]
metallb2[[dev]]
metallb3[[norham]]
router[[Router]]
dmz{{rudolfensis}}
k8s01{{habilis}}
k8s02{{antecessor}}
k8s03{{naledi}}
k8s04{{neanderthal}}
k8s05{{erectus}}
k8s06{{floresiensis}}
k8s07{{norham01}}
k8s08{{norham02}}
k8s09{{norham03}}
k8s10{{norham04}}
```

## Apache

- Install: `sudo apt install apache2`
- Create a `VirtualHost` file in `/etc/apache2/sites-available`
- Enable modules: `sudo a2enmod ssl proxy rewrite proxy_html proxy_http proxy_wstunnel`
- Install certbot: `sudo snap install --classic certbot`
- Configure certbot for apache: `sudo certbot --apache`
- Create a `VirtualHost` file in `/etc/apache2/sites-available`, e.g. `proxmox.conf`
- Enable site with `sudo a2ensite proxmox`
- Add certbot sites with e.g. `certbot --expand -d nextcloud.muso.club`
- NOTE: If forwarding to a k8s cluster with ingress certificate management: The http to https redirect that Certbot adds needs to be disabled, otherwise certificate generation on the cluster will not work, as the http listener set up by Certificate Issuer will not be reachable.

### Sample virtual host config

```conf
# Rudolfensis Apache configuration file for proxmox.muso.club
<VirtualHost *:443>
  SSLProxyEngine on
  SSLProxyVerify none
  ProxyPreserveHost on
  ProxyPass /  https://192.168.2.51:8006/
  ProxyPassReverse /  https://192.168.2.51:8006/
  ProxyRequests Off
  SSLProxyCheckPeerName off
  ServerName proxmox.muso.club
SSLCertificateFile /etc/letsencrypt/live/proxmox.muso.club/fullchain.pem
SSLCertificateKeyFile /etc/letsencrypt/live/proxmox.muso.club/privkey.pem
Include /etc/letsencrypt/options-ssl-apache.conf
</VirtualHost>
<VirtualHost *:80>
  ServerName proxmox.muso.club
  ProxyPreserveHost on
  ProxyPass /  http://192.168.2.51:8006/
  ProxyPassReverse /  http://192.168.2.51:8006/
  ProxyRequests Off
RewriteEngine on
RewriteCond %{SERVER_NAME} =proxmox.muso.club
RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
</VirtualHost>
```

### Naledi

```bash
certbot --expand -d docs.podzone.net,musings.thruhere.net,uk2day.online,www.uk2day.online,muso.club,db.muso.club,console.muso.club,broadcast.muso.club,radio.muso.club,www.muso.club,content.podzone.net,nextcloud.muso.club,proxmox.muso.club,vpn.muso.club,littlecanton.one,dev.littlecanton.one,home.littlecanton.one,content.littlecanton.one,radiodb.littlecanton.one,console.littlecanton.one,broadcast.littlecanton.one
```

### Habilis

```bash
certbot --expand -d littlecanton.one,dev.littlecanton.one,home.littlecanton.one,content.littlecanton.one,radiodb.littlecanton.one,console.littlecanton.one,broadcast.littlecanton.one
```

```
  ServerName littlecanton.one
  ServerAlias dev.littlecanton.one
  ServerAlias home.littlecanton.one
  ServerAlias content.littlecanton.one
  ServerAlias radiodb.littlecanton.one
  ServerAlias console.littlecanton.one
  ServerAlias broadcast.littlecanton.one
```

- Note: apidocumentation.info served from Norham
- Note: dialplus44.com,www.dialplus44.com address managed by Charles

### Naledi certbot

```bash
certbot --expand -d docs.podzone.net,musings.thruhere.net,uk2day.online,www.uk2day.online,muso.club,db.muso.club,console.muso.club,broadcast.muso.club,radio.muso.club,www.muso.club,radio.thruhere.net,norma.blog.podzone.org,content.podzone.net,dialplus44.com,www.dialplus44.com,nextcloud.muso.club,proxmox.muso.club
```

### Current aggregated list, for rudolfensis

Add entries and check in before applying.

```bash
certbot --expand -d docs.podzone.net,musings.thruhere.net,uk2day.online,www.uk2day.online,muso.club,db.muso.club,console.muso.club,broadcast.muso.club,radio.muso.club,www.muso.club,radio.thruhere.net,console.thruhere.net,norma.blog.podzone.org,content.podzone.net,dialplus44.com,www.dialplus44.com,nextcloud.muso.club,proxmox.muso.club,vpn.muso.club
```

## Domain evaluation 30 May 2024

Domains in certbot spec that are used currently or to be retained

### Prod

- `docs.podzone.net`
- `musings.thruhere.net`
- `uk2day.online`
- `www.uk2day.online`

### Muso Club

- `muso.club`
- `db.muso.club`
- `console.muso.club`
- `broadcast.muso.club`
- `radio.muso.club`
- `www.muso.club`

### For non-prod radio

- `radio.thruhere.net`
- `console.thruhere.net`

### Wordpress instances

- `www.dialplus44.com`
- `dialplus44.uk`
- `dialplus44.com`
- `www.dialplus44.uk`
- `www.asazimusic.com`
- `asazimusic.com`
- `norma.blog.podzone.org`
- `adam.blog.podzone.org`
- `motttt.blog.podzone.org`
- `projecttoolkit.co.uk`
- `project-tech.co.uk`

### Fabric Ingress

- `content.podzone.net`
- `central.podzone.net`
- `control.podzone.net`
- `north.podzone.net`

## Unused DynDns hosts

- `east.podzone.net`
- `eastern.podzone.net`
- `southern.podzone.net`
- `west.podzone.net`
- `western.podzone.net`
- `colley.endoftheinternet.org`
- `mottttspot.servegame.org`
- `poc.endoftheinternet.org`
- `qapps.does-it.net`
- `qsolutions.endoftheinternet.org`
- `www.radio.muso.club`
- `gymyc.podzone.net`
- `charles.blog.podzone.org`
- `wordpress.podzone.org`
- `blog.podzone.org`
- `uktoday.blogsite.org`
- `uktoday.thruhere.net`
- `uktoday.podzone.org`
- `uktoday.podzone.net`
- `uktoday.blog.podzone.org`
- `www.jam.radio.fm`
- `jam.radio.fm`
- `console.jam.radio.fm`
- `broadcast.jam.radio.fm`
- `dj.radio.thruhere.net`
- `master.radio.thruhere.net`
- `radio.thruhere.net`
- `www.radio.thruhere.net`
- `dev.podzone.net`
- `prod.podzone.net`
- `northern.podzone.net`
- `ceph.northern.podzone.net`
- `dbgui.dev.podzone.net`

## References

- <https://github.com/mcallegari/qlcplus>
- <https://en.wikipedia.org/wiki/Server_Name_Indication>
- <https://serverfault.com/questions/1043940/apache-reverse-proxy-preserving-ssl>
- <https://www.reddit.com/r/sysadmin/comments/3vvz86/is_there_a_way_to_do_ssl_passthrough_via_an/>
- <https://eff-certbot.readthedocs.io/en/latest/using.html#re-creating-and-updating-existing-certificates>
