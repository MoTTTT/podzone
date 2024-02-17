# Task List: northern.podzone.net

The following checklist provides a high-level breakdown of the work that needs to be done. Each of these are further decomposed below, where required:

- [ ] Documentation
- [ ] k8s prod cluster build
- [ ] Networking build
- [ ] Ingress Build
- [ ] Security
- [ ] Storage
- [ ] Applications and Services
- [ ] Testing

## Task-list: Documentation

- [ ] Tasklist
- [ ] Hosts
- [ ] Network topology
- [ ] Inventory
- [ ] Site structure

## Task-list: k8s prod cluster build

- [X] Install power, network, and first two nodes
- [ ] Install ddclient and configure
- [X] Total clean-up: `snap remove microk8s`
- [X] Install microk8s, cluster nodes, and configure
- [ ] DynDNS and Router config for test domain

## Task-list: Networking build

- [X] Ethernet cabling from router to switch
- [X] Switch install and cabling to nodes
- [X] Router config: Static IP assignments
- [X] Client config: update hosts file
- [ ] Router config: Port forward
- [X] Router config: Set DHCP range to reserve LBR IP

## Storage

Node IP addresses have changed. This is not supported by Ceph. Ceph cluster to be re-built from scratch.

- [X] Total clean-up: `snap remove microceph`
- [X] reinstall ceph on each node
- [X] cluster ceph nodes
- [X] disk assignment

## Testing

- [ ] t360 unit: Geekbench
- [ ] Cluster High Availability testing
- [ ] Cluster failure recovery
- [ ] Web functional test
- [ ] Application functional test

## Procurement

### Three node cluster

- [X] EBay 20-11075-47632: 1 X t630 {dariaiddle 2}
- [X] EBay 11-11081-94689: 3 X 128GB 2280 SSD
- [X] EBay 23-11073-38931: 3 X 256GB 2242 SSD
- [X] EBay 23-11073-47935: 3 X 16GB DDR4 RAM
- [X] EBay 15-11092-59277: 1 X t630 {dariaiddle 3}
- [X] EBay 10-11096-24713: 1 X t520 {chillitech_ltd}

### Five node cluster

- [X] EBay 05-11112-51382: 5 X t630 {dariaiddle}
- [X] EBay 11-11107-65868: 5 X 16GB DDR4 RAM
- [ ] EBay 23-11098-89931: 1 X 256GB 2242 SSD
- [X] EBay 12-11141-17449: 5 X Cat6 0.5m ethernet cables
- [X] EBay 12-11141-17448: 5 X 128GB 2280 SSD
- [ ] EBay 12-11141-17446: 4 X 256GB 2242 SSD
- [X] Amazon 206-2426422-7388328: 8 Port Gigabit switch
- [X] The range: 6 way Power strip

### Data server

- [X] EBay 12-11141-17445: 1 X 2 TB 2280 SSD
- [ ] EBay 12-11141-17447: NVMe + SATA adapter
