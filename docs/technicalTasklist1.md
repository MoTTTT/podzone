# Task List: southern.podzone.net

The following checklist provides a high-level breakdown of the work that needs to be done. Each of these are further decomposed below, where required:

- [X] Documentation
- [X] k8s dev cluster build
- [X] k8s prod cluster build
- [X] Networking build
- [X] Ingress Build
- [ ] Security
- [X] Storage
- [ ] Applications and Services
- [ ] Testing

## Task-list: Documentation

- [X] Business brief
- [X] Consumer Cloud definition
- [X] Workload Success criteria
- [X] MVP deliverables
- [X] Network topology
- [X] Inventory
- [ ] Update documentation with production cluster details
- [X] Curate reference lists
- [ ] Site structure

## Task-list: k8s dev cluster build

- [X] james (upgrade RAM)
- [X] sigiriya (upgrade disk)
- [X] bukit
- [X] levant

## Task-list: k8s prod cluster build

- [X] Procurement: 3 X HP t630 Thinclient
- [X] Add second drive:  128 GB M.2 max 2242 modules
- [X] Host build: habilis
- [X] Host build: antecessor
- [X] Host build: naledi
- [ ] RAM upgrade: 8BG -> 16 GB
- [ ] Upgrade first drives
- [ ] Migrate DynDns updater to cluster (external-dns chart)
- [ ] Ingress load balancer

## Task-list: Networking build

- [X] Network design
- [X] Refactor wired network
- [X] Router config (port forward, dynamic dns)
- [X] https certificate for (qsolutions.endoftheinternet.org)
- [X] Load balancer (MetalLB)
- [X] DynDns WAN IP updates (ddclient)

## Task-list: Ingress Build

- [X] Certificate manager
- [X] Certificates  for 4 X LetsEncrypt host certs
- [X] Route to Apache static sites
- [X] Route to k8s dashboard
- [X] Route to Search GUI : Cancelled
- [X] Route to k8s API
- [X] Route to zope
- [X] Route to podzone docs
- [ ] DynDns updater operator

## Task-list: Security

- [X] TLS certificate solution
- [X] https for all external access
- [X] Apache hardening
- [ ] Kubernetes hardening
- [ ] Purge sensitive info from DB

## Task-list: Storage

- [X] Consolidate data from media
- [X] Consolidate assets into iCloud
- [X] Extract source into GitHub
- [X] Persistent storage for k8s cluster

### Task Breakdown: Consolidate data from media

- [X] /home/${USER} directories on bare metal X 3
- [X] /media on james
- [X] thumb drives X 12
- [X] external hard drives X 1
- [X] 2.5" replaced hard drives X 3 - Install in james
- [X] 3.5" replaced hard drives X 2 - Install in external enclosures

### Requirement: Consolidate data from media

- All information of interest on all media to go into iCloud
- All projects, including legacy and completed ones, into GitHub
- Sensitive data audit, and secure wipe where required
- Visible logical status labelling

## Task Breakdown: Extract source into GitHub

- [X] Book: Telling; BA Colley
- [X] Book: Cannon Becket; AH Colley
- [X] Book: All the Saints; AH Colley
- [X] Code: uNode assets
- [X] Code: BHC assets
- [X] Code: Archive/Backup search

## Task-list: Applications and Services

- [X] Consolidate Web sites
- [ ] Extract Zope zexp files and check in
- [ ] Containerise Zope, including application code and config

### Task Breakdown: Containerise Zope, including application code and config

- [X] Plone Service and Deployment
- [X] Plone ingress for qsolutions.endoftheinternet.org
- [X] Ingress rewrite rules for Zope Virtual Host Monster
- [ ] Plone ZPsycopgDA installation (containerInit?)
- [ ] Persistent storage volume for postgres
- [ ] Postgress Service and Deployment
- [ ] Postgress ingress

## Testing

- [ ] Cluster High Availability testing
- [ ] Cluster failure recovery
- [ ] Web functional test
- [ ] Application functional test