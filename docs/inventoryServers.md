# Bare Metal Inventory

The server inventory is split into "Production" and "Development".

## Production

For the production environment, second hand hardware was purchased. Hardware that became redundant due to a call-centre upgrade was purchased second-hand online.

The devices are HP t630 Thin Clients, for which the specifications are available from HP online: <https://support.hp.com/za-en/document/c05240287>.

The devices each had single 32GB M.2 SATA SSDs, and 8GB DDR4 RAM, which were upgraded, giving the following common configuration:

### HP t360 specs

- HP t630 Thinclient
- OS: Ubuntu Server 22.04 minimised
- AMD Quad Core CPU @ 2.0 Ghz
- 24Gb DDR4 RAM
- 128 GB M.2 SATA SSDs
- 256 GB M.2 SATA SSDs

The t360s have been assigned names and static IP addresses as follows:

- habilis: 192.168.0.4
- antecessor: 192.168.0.14
- naledi: 192.168.0.21

## Development Environment

Three personal machines and workstations were re-purposed to create a dev environment. Upgrades to disk and ram were done where possible. It would have been great to get RAM on all devices up to 16GB, or more, but unfortunately only one device accommodated upgrade, and that to only 16GB.

### sigiriya

- Late 2014 Mac Mini
- 2.80GHz i5-4308U (2 core, 4 thread)
- 8GB RAM (soldered)
- Ubuntu Server 22.04 (upgrade from macOS)
- 2TB SSD (upgrade from 500GB)
- eth0 IP: 192.168.0.6

### bukit

- Late 2014 Mac Mini
- 1.4 GHz Dual Core i5
- 4 GB RAM (soldered)
- Ubuntu 22.04 desktop (existing installation)
- 500GB SSD
- eth0 IP: 192.168.0.52
- admin user: martin

### james

- Motherboard: ASRock H61M-VS3
- 3 GHz Quad Core i5
- 16GB (upgrade from 8 GB) RAM
- Ubuntu 22.04 desktop (existing installation)
- 500 GB SSD
- eth0 IP: 192.168.0.27
