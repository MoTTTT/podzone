# Server Inventory

As cluster build-out has progressed, devices and their resource configuration have evolved:

- The original development environments comprised equipment on hand.
- The next set of hardware selected for kubernetes and ceph clusters are Thin Clients, with 4 CPUs; 25GB RAM; 128 + 256 GB SSD each. Fourteen of these were put into service.
- The current set of hardware, for hyper-converged infrastructure are 2U rack servers, with up to 48 CPUs, 256 GB RAM, and 4.8TB SAS Storage. There are currently six of these in various stages of procurement and provisioning.

## Rack servers

| Hostname | Machine | Threads | RAM        | RAM Config | Controller |  SAS installed          | IP Address   | Function     |
|----------|---------|---------|------------|------------|------------|-------------------------|--------------|--------------|
| Pluto    | R720    | 32      |            |            |            | 8 X 2.5"                | 192.168.2.50 | Production 1 |
| Mars     | R720    | 32      | 384 GB     | 24 X 16GB  | H710P Mini | 12 X 600GB + 2 X 1TB    | 192.168.2.54 | Production 2 |
| Saturn   | DR6000  | 48      | 128 GB     |            |            | 2 X 2.5"; 12 X 3.5"     | 192.168.2.51 | DevOps       |
| Venus    | R730    | 64      | 160 GB     |            | H730 Mini  | 8 X 2.5"                | 192.168.2.53 | Home Lab.    |
| Mercury  | R720    | 32      | 112 GB     | 14 X 8 GB  |            | 4 X 147 GB + 4 X 600 GB | 192.168.3.52 | Recovered.   |

## Cluster nodes

Cluster nodes are HP t630 Thin Clients, for which the specifications are available from HP online: <https://support.hp.com/za-en/document/c05240287>.

The devices were purchased second hand, and typically had limited RAM and disk installed (e.g. 32GB disk, and 8GB DDR4 RAM).

RAM and disk were installed, giving the following common node configuration:

### HP t360 specs

- HP t630 Thinclient
- OS: Ubuntu Server 22.04 minimised
- AMD Quad Core CPU @ 2.0 Ghz
- 24Gb DDR4 RAM
- 128 GB M.2 SATA SSDs
- 256 GB M.2 SATA SSDs

## northern zone solution

### http request router

In order to support multiple k8s clusters on the northern network served by a single static IP assigned by the ISP,
without any cluster depending on another, an HP t520 device is added to the solution to serve a reverse proxy (apache) function.
Routing of https requests at the proxy is  based on domain name. In addition, the domain name IP address management function (ddclient)
and tls certificate management for the reverse proxy (certbot) are provided on this device:

- rudolfensis:  t520; apache, ddclient, certbot

### Kubernetes nodes

The northern zone solution has the following node configuration:

- naledi:       t630; k8s, ceph
- habilis:      t630; k8s, ceph
- antecessor:   t630; k8s, ceph
- neanderthal:  t630; k8s, ceph
- erectus:      t630; k8s, ceph
- floresiensis: t630; k8s, ceph
- norham01:     t630; k8s, ceph
- norham02:     t630; k8s, ceph
- norham03:     t630; k8s, ceph
- norham04:     t630; k8s, ceph

### Cluster resource totals

- Total t630 CPU: 40 cores
- Total t630 RAM: 200 GB
- Total t630 Raw Disk: 2.5 TB

## southern zone solution

- denisova:     t630; k8s, ceph, ddclient, ularu
- rudolfensis:  t630; k8s, ceph
- ergaster:     t630; k8s, ceph
