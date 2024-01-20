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

- [ ] Install power, network, and first two nodes
- [ ] Install ddclient and configure
- [ ] Total clean-up: `snap remove microk8s`
- [ ] Install microk8s, cluster nodes, and configure
- [ ] 

## Task-list: Networking build

- [ ] Ethernet cabling from router to switch
- [ ] Switch install and cabling to nodes
- [ ] Router config: Static IP assignments
- [ ] Client config: update hosts file
- [ ] Router config: Port forward
- [ ] Router config: Set DHCP range to reserve LBR IP

## Storage

Node IP addresses have changed. This is not supported by Ceph. Ceph cluster to be re-built from scratch.

- [ ] Total clean-up: `snap remove microceph`
- [ ] reinstall ceph on each node
- [ ] cluster ceph nodes
- [ ] disk assignment



## Testing

- [ ] Cluster High Availability testing
- [ ] Cluster failure recovery
- [ ] Web functional test
- [ ] Application functional test

