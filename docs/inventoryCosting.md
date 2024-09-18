# Costing

## Enterprise hardware

### Servers

- Pluto: Dell PowerEdge R720 2x Intel Xeon E5-2650 V1 @2.00GHz 8x8GB RAM, No HDD. {£51}
- Saturn: Dell DR6000 2x E5-2695 V2 2.6Ghz No RAM DDR3 H710 1100W. {£59}
- Mars: DELL PowerEdge R720 2 X Xeon E5-2650 V2 2x 1TB SAS {£70}
- Mercury: Dell PowerEdge R720 16x SFF Storage Rack Server 2x Xeon CPU No RAM 2x 600gb Hdd {£88}
- Venus: Dell PowerEdge R730 Xeon 2 x E5-2698 V3, 160GB RAM, H730 Mini {£104}
- Neptune: Dell PowerEdge R720 Rack Mount Server (Xeon 5677, 24GB RAM, 6 Caddies, No HDDs) {£52}

### Disks and caddies

- 4x SEAGATE CONSTELLATION 3TB ES.3 ST3000NM0023 3.5" 6G SAS HDD {£16.00}
- 8 X Dell 147GB 2.5" 10K SAS HDD {£15}
- 4 X HGST 600GB 10K RPM 2.5" SFF SAS HDD {£19}
- 20 x Assorted 600GB 6Gbps 2.5" SAS HDD {£31}
- 8 X Dell 2.5" Hard Drive Tray Caddy {£36}
- 4 X Dell 2.5" Hard Drive Tray Caddy {£18}
- 2 X SAS Hard Disk Drive SFF-8482 Male To Female Extension Cable BS {£15}

### Memory

- 24 x 16GB Hynix DDR3-1066MHz 4Rx4 {£51}}
- 16 x 16GB Hynix DDR3-1066MHz 4R4 {£66}

### Networking

- Dell PowerConnect 5324 24xRJ-45 1G Managed Switch {£10}
- 2m Optical Fibre Cable  Multi-Mode Duplex {£4}
- SFP+ Optical Transceiver  Nokia 9.8GB {£1}
- SFP Optical Transceiver Finisar 4GB {£5}
- SFP Optical Transceiver Prolabs 10G {£4}
- 2 X 1m OM4 Fibre Optic Patch Cable LC-LC Multi-Mode Network Lead UPC 50/125µm Duplex {£10}
- 4 X 0.5m OM4 Fibre Optic Patch Cable LC-LC Multi-Mode Network Lead UPC 50/125µm Duplex {£20}
- 7 x HP HPE 16Gb SW B-series SFP+ Fibre Channel Transceivers QK724A 656435-001 {£32}

## Consumer hardware

### Hardware selection

The following criteria were used to short-list potential hardware:

- DDR4 RAM capacity
- No of CPU Cores, and processor speed
- SSD module capacity
- Recovered or second hand hardware
- Small form factor
- Low noise

The HP t630 meets these requirements, although has a limitation of only supporting SATA SSDs. At the time of this project there are many units available, as they were popular for scaled call centre and office use. These varied widely in price. Those without power supply and cable are not of use, so check before ordering.

The t630s purchased for build of cluster nodes have the following capacities:

- 4 X 2.2GHz CPU cores (AMD GX-420GI)
- 2 X SODIMM DDR4 RAM slots (Max capacity 64GB RAM)
- 2 X M.2 SATA SSD slots (1 X 2242 max modules, 1 X 2280 max modules)

## Drives

The t630 has two M.2 SATA slots:

- Primary module slot: Up to size 2242 modules. The devices purchased were populated with 32GB modules.
- Secondary module slot: Up to size 2280 modules

Secondary modules of 256GB were purchased for dedicated ceph disks.

Once operating system, kubernetes and ceph were installed, ceph gave space threshold warnings for the boot device, so 32GB proved too small for the boot device.  With Ubuntu Server 22.04 minimised, microk8s and ceph installed and configured and the baseline application workload deployed, ceph *MON_DISK_LOW* health checks were failing. Primary modules were therefore upgraded to 128GB.

With 256GB allocated to each ceph node, with 3 replicas of each object stored, safe cluster size is 170GB.

### Drive issues

1. Availability of M.2 SATA SSDs is limited. M.2 NVME SSDs, which are more easily available than the SATAs are not supported.
1. Availability of M.2 size 2242 M.2 modules is limited, the 2280 size modules being more easily available.
1. Some of the t630s devices did not support adjusting the BIOS to boot from the secondary module slot, requiring a 2242 size boot device module.
1. Stock of each of the modules is limited. Online ordering cancellations due to availability happened more than once.

As a result of these constraints, some modules were over specified for their purpose, but for all devices, at least 128GB was assigned to the boot SSD.

NOTE: The UK refurbished / second hand parts online market is easy, quick and reliable. Ebay would be good to have in SA.

### RAM

The t630 has two DDR4 RAM slots. The devices purchased were populated with one 8GB module.

An additional 16GB module was purchased to make up for a total of 24 GB.

A minimum of 256 MB RAM is allocated to GPU. BIOS configuration reduced this from the default of 1 GB.

Scaling up would be easy while DDR4 RAM is available, first replacing the 8GB modules with e.g. 32GB modules.

Maximum supported RAM for a three node cluster would be 191GB, once dedicated GPU RAM is considered.

## Example Pricing: SA

- t630 unit price: R900
- M.2 SATA 256GB SSD: R469
- M.2 SATA 128GB SSD: R339
- 16GB DDR4 RAM: R899
- Node cost: R2607 == £116

## Example Pricing: UK

- t630 unit price: £35 (1 ordered)
- M.2 SATA 2242 256GB SSD: £18.66 (3 ordered)
- M.2 SATA 2280 128GB SSD: £13.95 (3 ordered)
- 16GB DDR4 RAM: £19.99 (3 ordered)
- Node cost: £88 == R2125

## SSD pricing

### m.2 SATA

- 128GB £14 : £112/TB
- 256GB £20 : £80/TB
- 512GB £30 : £60/TB
- 1TB £55   : £55/TB
- 2TB £100  : £50/TB

### m.2 nvme

- 215 GB £25 : 100
- 1 TB £53
- 2 TB £120 : 60
- 4 TB £233 : 58

## Hardware purchase reconciliation

### Q Solutions

| Date       | Vendor | Component            | Unit Price | Quantity | Total  |
|------------|--------|----------------------|------------|----------|--------|
| 21/01/2024 | Ebay   | HP T630              | 34,99      | 1        |  34,99 |
| 21/01/2024 | EBay   | 2280 M.2 SATA 128GB  |  7,99      | 3        |  23,97 |
| 21/01/2024 | Ebay   | 2242 M.2 SATA 256GB  | 17,09      | 3        |  55,98 |
| 21/01/2024 | Ebay   | DDR4 16GB RAM        | 19,98      | 3        |  59,94 |
| 24/01/2024 | Ebay   | HP T630              | 33,64      | 1        |  33,64 |
| 24/01/2024 | Ebay   | HP T520              | 29,00      | 1        |  29,99 |
| 14/02/2024 | Ebay   | .5 m Cat 6 Cable     |  2,29      | 5        |  11,45 |
| 14/02/2024 | Ebay   | 1.5 m Cat 6 Cable    |  2,29      | 3        |   7,77 |
| 13/03/2024 | Ebay   | Dell PowerEdge R720  | 51,00      | 1        |  51,00 |
|            |        | Total                |            |          |£308,73 |
 
### Norham 
 
| Date       | Vendor | Component            | Unit Price | Quantity | Total  |
|------------|--------|----------------------|------------|----------|--------|
| 28/01/2024 | Ebay   | HP T630              | 32,80      | 5        | 164,00 |
| 28/01/2024 | Ebay   | DDR4 16GB RAM        | 19,99      | 5        |  99,95 |
| 28/01/2024 | Ebay   | 2242 M.2 SATA 256GB  | 19,49      | 1        |  19,49 |
| 04/02/2024 | Ebay   | 2280 M.2 SATA 2TB    | 99,99      | 1        |  99,99 |
| 04/02/2024 | Amazon | 8 Port GB Switch     | 14,99      | 1        |  14,99 |
| 07/02/2024 | Ebay   | 2242 M.2 SATA 256GB  | 18,06      | 4        |  72,20 |
| 07/02/2024 | Ebay   | PCIe > M.2 NVMe SATA |  5,93      | 1        |   5,93 |
| 07/02/2024 | Ebay   | 2280 M.2 SATA 128GB  | 11,99      | 5        |  59,95 |
| 07/02/2024 | Ebay   | .5 m Cat 6 Cable     |  2,29      | 5        |  11,45 |
|            |        | Total                |            |          |£547,95 |

## References

- HP t630 specs: <https://support.hp.com/za-en/document/c05240287>
- Ceph storage capacity calculator: <https://florian.ca/ceph-calculator/>
