# Overflow and historical information on original zone

```mermaid
---
title: southern.podzone.net Network Topology, Original
---
graph LR

ISP --- ont
ont --- router
router --- switch2
router ---switch3
router --- ap1
router --- other2
router --- workstation
ap1 --- other1
ap1 --- other2
switch2 --- other1
switch3 --- switch1
switch3 --- other1
switch1 <-->|1GB| k8s1
switch1 <-->|1GB| k8s2
switch1 <-->|1GB| k8s3
switch1 <-->|1GB| k8s4

ont[[Daisan H665 GPON ONT]]
router[[TP-LINK EC120-F5 Router]]
switch1[[D-Link DGS-1005D]]
switch2[[TP-Link TL-SG1005D]]
switch3[[TP-Link TL-SG1008D]]
ap1[[TP-Link TL-WR845N]]
other1(ethernet devices)
other2(wifi devices)
k8s1{{levant}}
k8s2{{james}}
k8s3{{bukit}}
k8s4{{sigiriya}}
workstation(dolmen)
```

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