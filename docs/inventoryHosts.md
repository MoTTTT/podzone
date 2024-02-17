# Hosts Inventory

This page provides convenience listings of hosts file entries, and details of devices not already listed.

## hostnames relevant to the podzone project

DNS domains hosted DynDns have been in use for years (the first paid for service was ordered in 2008) and will be used further for this project.

### Hostnames for minimum viable product

- southern.podzone.net
- musings.thruhere.net
- qsolutions.endoftheinternet.org
- docs.podzone.net
- mottttspot.servegame.org

### Hostnames configured for future use

- central.podzone.net
- control.podzone.net
- dev.podzone.net
- east.podzone.net
- eastern.podzone.net
- north.podzone.net
- northern.podzone.net
- west.podzone.net
- western.podzone.net

### Hostnames made redundant

These sites are becoming redundant with the MVP implementation, and can be cleaned up:

- colley.endoftheinternet.org
- poc.endoftheinternet.org
- qapps.does-it.net

## Ingress hosts

Ingress hosts make use of the DNS entries defined above. `southern.podzone.net` is a wildcard entry used by some of these.

- <https://musings.thruhere.net>: Routing to Apache instance for serving a static web site.
- <https://qsolutions.endoftheinternet.org>: Routing to a Zope application server, serving QSolutions Applications.
- <https://control.southern.podzone.net>: Routing to kubernetes API.
- <https://db.southern.podzone.net>: Routing to database GUI console.
- <https://ceph.southern.podzone.net:8443/>: Routing to Ceph dashboard.

## IP Address Management: southern

The internal network uses the `192.168.0.0/24` subnet, providing 256 unique IP addresses. The first set are assigned to the DHCP server for allocation, allowing layer 2 load balanced routers to be defined in the same subnet. Static IPs are assigned to all kubernetes hosts, configured on the router as static, on initial lease.

- `192.168.0.2 - 192.168.0.99`: Addresses assigned to the router DHCP server
- `192.168.0.104 - 102.168.0.111`: (`192.168.0.104/29`) Wireguard
- `192.168.0.131 - 192.168.0.140`: L2 load-balancer IP address range for dev on bare metal
- `192.168.0.141 - 192.168.0.150`: L2 load-balancer IP address range for dev on virtual servers
- `192.168.0.151 - 192.168.0.151`: L2 load-balancer IP address range for production (southcluster)
- `192.168.0.152 - 192.168.0.152`: L2 load-balancer IP address range for production (northcluster)
- `192.168.0.160`: Hercules static IP assignment
- `192.168.0.160`: Hercules static IP assignment

## IP Address Management: northern

The internal network uses the `192.168.1.0/24` subnet, providing 256 unique IP addresses. The DHCP server currently serves all of these, requiring adjustment to allow a layer 2 load balanced routers to be defined in the same subnet. Static IPs are assigned to all kubernetes hosts, configured on the router as static, on initial lease. Since the subnet differs from the site the nodes were built on, rebuild of the ceph clusters will be required, and may be required for microk8s.

- `192.168.0.2 - 192.168.0.99`: Addresses assigned to the router DHCP server
- `192.168.0.152 - 192.168.0.152`: L2 load-balancer IP address range for production (northcluster)
- `192.168.1.220 - 192.168.1.220`: L2 L2 load-balancer IP address range for production (northcluster) UK

## /etc/hosts

The text block below contains the full hosts file entry list, mainly useful on the admin client.

- Add `/etc/hosts` file entries on servers
- Add `/private/etc/hosts` for Mac clients

### Original Site

```text
# Workstations
192.168.0.6   sigiriya
192.168.0.18  dolmen
192.168.0.27  james

# Cluster Nodes
192.168.0.4   habilis
192.168.0.14  antecessor
192.168.0.21  naledi
192.168.0.7   denisova
192.168.0.30  rudolfensis
192.168.0.33  ergaster
```

Turned down:

```text
# Dynamic VM, will be assigned IP on startup:
192.168.0.47  ularu

# Mac mini, rebuild for sale
192.168.0.52  bukit

# IoT Devices
192.168.0.11  anasazi
192.168.0.28  levant
192.168.0.131 ovoo
192.168.0.13  balin
192.168.0.20  thorin
192.168.0.26  dwalin
```

## Northern interim site

```text
# Workstations
192.168.0.18  dolmen

# VMs
192.168.1.115  ularu

# Cluster Nodes
192.168.1.117  habilis
192.168.1.113  antecessor
192.168.1.112  naledi
192.168.1.130  neanderthal
192.168.1.131  erectus
192.168.1.137  floresiensis
192.168.1.134  rudolfensis
192.168.1.140  norham01
192.168.1.141  norham02
192.168.1.142  norham03
192.168.1.143  norham04
```
