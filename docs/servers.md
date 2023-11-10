# Bare Metal Inventory

The server inventory is split into "Production" and "Development".

## Development Environment

A number of personal machines and workstations (and a capable edge device) were re-purposed to create a dev environment. Upgrades to disk and ram were done where possible. It would have been great to get RAM on all devices up to 16GB, but unfortunately only one device accommodated this.

### sigiriya

- Late 2014 Mac Mini
- 2.80GHz i5-4308U (2 core, 4 thread)
- 8GB RAM (soldered)
- Ubuntu Server 22.04 (upgrade from mcOS)
- 2TB SSD (upgrade from 500GB)
- eth0 IP: 192.168.0.6
- eth1 IP:
- dolmen key exchange: ssh colleymj@sigiriya

### bukit

- Late 2014 Mac Mini
- 1.4 GHz Dual Core i5
- 4 GB RAM (soldered)
- Ubuntu 22.04
- 500GB SSD
- eth0 IP: 192.168.0.52
- eth1 IP:
- dolmen key exchange: ssh martin@bukit

### james

- Motherboard: ASRock H61M-VS3
- 3 GHz Quad Core i5
- 16GB (upgrade from 8 GB) RAM
- Ubuntu 22.04
- 500 GB SSD
- eth0 IP: 192.168.0.27
- eth1 IP:
- dolmen key exchange: ssh colleymj@james

### levant

- Raspberry Pi 4 B
- 1.8GHz Broadcom BCM2711, Quad Core Cortex-A72
- 4GB RAM
- Ubuntu Core 22
- IP: 192.168.0.28

## Production southern.podzone.net

For the production environment, second hand hardware was purchased. Hardware that became redundant due to a call-centre upgrade was purchased second-hand online.

The devices are HP t630 Thin Clients, for which the specifications are available from HP online: <https://support.hp.com/za-en/document/c05240287>.

Additional disk was added for the ceph cluster. If necessary, the RAM and first disk can be upgraded.

### habilis

- HP t630 Thinclient
- AMD Quad Core CPU @ 2.0 Ghz
- 8Gb DDR4 ram
- 32 GB SSD
- Additional SSD slot: Install 128 GB M.2 max 2242 module
- MAC: 7C-D3-0A-76-64-E3
- IP: 192.168.0.4

### antecessor

- HP t630 Thinclient
- AMD Quad Core CPU @ 2.0 Ghz
- 8Gb DDR4 ram
- 32 GB SSD
- Additional SSD: Install 128 GB M.2 max 2242 module
- MAC: 7C-D3-0A-77-0D-8D
- IP: 192.168.0.14

### naledi

- HP t630 Thinclient
- AMD Quad Core CPU @ 2.0 Ghz
- 8Gb DDR4 ram
- 32 GB SSD
- Additional SSD: Install 128 GB M.2 max 2242 module
- MAC: 7C-D3-0A-3E-EB-D1
- IP: 192.168.0.21

