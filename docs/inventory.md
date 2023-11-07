# Inventory

## Bare metal

### k8s node: sigiriya

- Late 2014 Mac Mini
- 2.80GHz i5-4308U (2 core, 4 thread)
- 8GB RAM (soldered)
- Ubuntu Server 22.04 (upgrade from mcOS)
- 2TB SSD (upgrade from 500GB)
- eth0 IP: 192.168.0.6
- eth1 IP:
- dolmen key exchange: ssh colleymj@sigiriya

### k8s node: bukit

- Late 2014 Mac Mini
- 1.4 GHz Dual Core i5
- 4 GB RAM (soldered)
- Ubuntu 22.04
- 500GB SSD
- eth0 IP: 192.168.0.52
- eth1 IP:
- dolmen key exchange: ssh martin@bukit

### k8s node: james

- Motherboard: ASRock H61M-VS3
- 3 GHz Quad Core i5
- 16GB (upgrade from 8 GB) RAM
- Ubuntu 22.04
- 500 GB SSD
- eth0 IP: 192.168.0.27
- eth1 IP:
- dolmen key exchange: ssh colleymj@james

### k8s node: levant

- Raspberry Pi 4 B
- 1.8GHz Broadcom BCM2711, Quad Core Cortex-A72
- 4GB RAM
- Ubuntu Core 22
- IP: 192.168.0.28

## Prod southern.podzone.net

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


## multipass dev nodes

### multipass instance: ardipithecus

### multipass instance: australopithecus

### multipass instance: tugenensis

### multipass instance: tchadensis

## k8s virtualbox dev nodes

These instances are managed as follows:

- Vagrant to spin up the virtualbox machines, and prepare ssh access
- Vagrant box image: <https://app.vagrantup.com/techchad2022/boxes/ubuntu2204>
- Ansible for microk8s installation and configuration

### virtualbox on james: floresiensis

- MAC: 08-00-27-8A-AA-C5
- IP: 192.168.0.19

### virtualbox on james: denisova

- MAC: 08-00-27-19-87-6B
- IP: 192.168.0.5

### virtualbox on james: rudolfensis

- MAC: 08-00-27-1C-B8-7E
- IP: 192.168.0.16

### virtualbox on james: ergaster

- MAC: 08-00-27-5D-14-DB
- IP: 192.168.0.17

## Other devices

### k8s lbr: oovo

- MetalLBR L2 (ARP) Load balancer
- IP: 192.168.0.131

### Raspberry Pi: balin

- Model: Raspberry Pi Model B Rev 2
- ARMv6-compatible processor rev 7 (v6l)
- MAC: B8-27-EB-AB-1A-F3
- IP: 192.168.0.13

### Raspberry Pi: thorin

- Model: Raspberry Pi Model B Rev 2
- ARMv6-compatible processor rev 7 (v6l)
- MAC: B8-27-EB-05-94-A7
- IP: 192.168.0.20

### Raspberry Pi: dwalin

- Model: Zero W
- MAC: B8-27-EB-7C-FE-CA
- IP: 192.168.0.26

### Raspberry Pi: anasazi

- Model: Raspberry Pi 2 Model B Rev 1.1
- Quad Core 1.2GHz Broadcom BCM2837 64bit CPU {4 X ARMv7 Processor rev 5 (v7l)}
- 1GB RAM
- IP: 192.168.0.11
- MAC: B8-27-EB-BE-0D-EB

### Raspberry Pi: levant

- Model: 4 B
- 1.8GHz Broadcom BCM2711, Quad Core Cortex-A72
- 4GB RAM
- Ubuntu Core 22
- IP: 192.168.0.28

### Admin Client: dolmen

- MacBook Pro
- Apple M1
- 16GB RAM
- macOs Ventura 13.5.2

### Virtual server: ularu

- Virtualbox on bukit
- Ubuntu 16.04.7
- Zope Version 2.13.24 (python 2.7.11, linux2)
- QApps release 3.0
- 1GB RAM
- IP: 192.168.0.3
- MAC: 08-00-27-C3-E9-F6
- ssh colleymj@ularu -p 2222
- NOTE: To be turned down

## Host lists

### /etc/hosts

- Add `/etc/hosts` file entries on servers
- Add `/private/etc/hosts` for Mac clients

```text
192.168.0.6   sigiriya
192.168.0.11  anasazi
192.168.0.18  dolmen
192.168.0.27  james
192.168.0.28  levant
192.168.0.52  bukit
192.168.0.131 ovoo
192.168.0.132 inuksuk
192.168.0.3   ularu
192.168.0.5   denisova
192.168.0.16  rudolfensis
192.168.0.17  ergaster
192.168.0.19  floresiensis
192.168.0.13  balin
192.168.0.20  thorin
192.168.0.26  dwalin
192.168.0.4   habilis
192.168.0.14  antecessor
192.168.0.21  naledi
```

### Ingress hosts

- Apache: `musings.thruhere.net`
- Tests: `qapps.does-it.net`
- Zope - QApps: `qsolutions.endoftheinternet.org`
- K8s API: `control.southern.podzone.net`
- Dashboard: `dashboard.southern.podzone.net`
- Opensearch GUI: `opensearch.southern.podzone.net`
- Fluentd Kibana GUI: `kibana.southern.podzone.net`

### wildcard hostnames on DynDns

- central.podzone.net
- colley.endoftheinternet.org
- control.podzone.net
- dev.podzone.net
- docs.podzone.net
- east.podzone.net
- eastern.podzone.net
- musings.thruhere.net
- north.podzone.net
- northern.podzone.net
- poc.endoftheinternet.org
- qapps.does-it.net
- qsolutions.endoftheinternet.org
- southern.podzone.net
- west.podzone.net
- western.podzone.net

### IP Addresses

- Static IPs for all bare-metal hosts
- DHCP assigned addresses: 192.168.0.2 - 192.168.0.99
- MetalLB production: 192.168.0.131 - 192.168.0.140
- MetalLB dev: 192.168.0.141 - 192.168.0.150
- MetalLB south: 192.168.0.151 - 192.168.0.151

## References

- HP t630 Thin Client Specifications: <https://support.hp.com/za-en/document/c05240287>
