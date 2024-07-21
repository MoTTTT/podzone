# Hardware planning

## Hardware categories

- Enterprise hardware
- Production Kubernetes Cluster
- IT Development devices
- Workstations
- IoT Devices

## Enterprise hardware

### Pluto

- Dell PowerEdge R720
- 16 X CPU cores: 2x Intel Xeon E5-2650 V1 @2.00GHz
- 4 X 1GbE Ethernet Ports: (FM487 Quad Port Broadcom 5720 Network Card)
- 8 x 8GB RAM
- 8 X 147GB SAS 2.5" HDD Storage

### Backup / temporary SAS storage solution

- 4x SEAGATE CONSTELLATION 3TB ES.3 ST3000NM0023 3.5" 6G SAS HDD
- 2 X SAS Hard Disk Drive SFF-8482 Male To Female Extension Cable BS

### Hardware allocation

- CPU unit resource ratio: 1 Unit = {1 Core; 4 GB RAM; 73 GB OS Disk}
- Total 16 Units on Pluto
- 4 X {1 Core; 4 GB RAM; 73 GB Disk}: ceph / gateway / tftp / dhcp
- 4 X {2 Core; 8 GB RAM; 73 GB Disk}: k8s
- 1 X {4 Core; 16 GB RAM; 147 GB Disk}
- 4 X {73 GB Disk RAW}: Ceph / iSCSI

### Network Architecture

- FM487 Quad Port Broadcom 5720 Network Card
- 4 X 1GbE Ethernet Ports
- Assignment: Ethernet Port 1 LAN 1
- Assignment: Ethernet Port 2 LAN 2
- Assignment: Ethernet Port 3 cluster network 1
- Assignment: Ethernet Port 4 cluster network 2

### Storage Architecture

- Pluto: Using 8 X SAS 147GB HDDs in RAID0 configuration

References:

- <https://ubuntu.com/server/docs/iscsi-initiator-or-client>
- <https://en.wikipedia.org/wiki/Standard_RAID_levels>
- <https://en.wikipedia.org/wiki/Non-standard_RAID_levels>
- <https://www.techtarget.com/searchstorage/definition/RAID-10-redundant-array-of-independent-disks>
- <https://en.wikipedia.org/wiki/Logical_Volume_Manager_(Linux)>
- <https://jonamiki.com/2015/01/23/view-create-delete-virtual-raid-volumes-with-racadm-on-an-r720-server-dell-12g/>

### Hypervisors

- <https://phoenixnap.com/kb/what-is-hypervisor-type-1-2>
- <https://phoenixnap.com/kb/ubuntu-install-kvm>
- <https://ubuntu.com/blog/kvm-hyphervisor>
- <https://microstack.run/docs/single-node>
- <https://www.linuxtechi.com/how-to-install-kvm-on-ubuntu-22-04/>
- <https://canonical-microcloud.readthedocs-hosted.com/en/latest/how-to/commands/#howto-commands>
- <https://documentation.ubuntu.com/lxd/en/latest/tutorial/first_steps>

### IDRAC

- <https://docs.openstack.org/ironic/wallaby/admin/drivers/idrac.html>
- <https://www.dell.com/support/manuals/en-uk/idrac9-lifecycle-controller-v3.0-series/idrac_3.00.00.00_ug/idrac-licenses>
- <https://snippets.bentasker.co.uk/page-1708021031-racadm-cheatsheet-for-Dell-iDRAC-BASH.html>
- <https://github.com/Cizin/Idrac-cheat-sheet>
- <https://dl.dell.com/manuals/all-products/esuprt_software/esuprt_remote_ent_sys_mgmt/esuprt_rmte_ent_sys_rmte_access_cntrllr/integrated-dell-remote-access-cntrllr-7-v1.50.50_reference%20guide4_en-us.pdf>
- <https://jonamiki.com/2015/01/23/view-create-delete-virtual-raid-volumes-with-racadm-on-an-r720-server-dell-12g/>

## Consumer hardware Kubernetes Cluster

- 10 X HP t360 {4 CPU, 24 GB RAM, 128 GB Disk (OS) + 256 GB Disk (Raw)}
- Even ratio unit = {1 CPU, 6 GB RAM, 32 GB Disk}
- Even ratio unit = {1 CPU, 6 GB RAM, 32 GB Disk}
- Reference, no storage?: <https://support.hp.com/gb-en/document/c05240287>
- Reference, has storage: <https://support.hp.com/gb-en/document/c05847930>

- <https://www.miccet.nl/2023/01/11/extra-nic-on-the-hp-thin-client-t630/>
- <https://www.ebay.com/p/24053807327?iid=134188279673>
- <https://www.reddit.com/r/homelab/comments/x49xw5/hp_t630_thin_client_as_a_ubuntu_server/>

### IT Development devices

- Mac mini 1:
- Mac mini 2:

### Workstations

- Macbook: dolmen
- Ubuntu desktop: james

### IoT Devices
