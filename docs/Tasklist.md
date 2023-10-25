# Tasks for building Consumer Cloud Zone 1: southern.podzone.net

Each of these are further decomposed below:

- [X] Business brief
- [X] Consumer Cloud definition
- [X] Workload Success criteria
- [X] MVP deliverables
- [X] k8s cluster build
- [X] Networking build
- [X] Ingress Build
- [X] Persistent storage
- [ ] Security
- [X] Expose k8s API
- [ ] Applications and Services

## Security

- [X] TLS certificate solution

## Task-list: k8s cluster build

- [X] james (upgrade RAM)
- [X] sigiriya (upgrade disk)
- [X] bukit
- [X] levant

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
- [ ] Route to podzone docs
- [ ] DynDns updater operator

## Security

- [X] https for all external access
- [ ] enable rbac
- [ ] configure dashboard access controls
- [ ] user management

## Task-list: Storage Applications and Services

- [X] Consolidate assets into iCloud
- [X] Extract source into GitHub
- [ ] Extract Zope zexp files and check in
- [ ] Containerise Zope, including application code and config
- [X] Consolidate Web sites

### Task Breakdown: Containerise Zope, including application code and config

- [X] Plone Service and Deployment
- [X] Plone ingress for qsolutions.endoftheinternet.org
- [X] Ingress rewrite rules for Zope Virtual Host Monster
- [ ] Plone ZPsycopgDA installation (containerInit?)
- [ ] Persistent storage volume for postgres
- [ ] Postgress Service and Deployment
- [ ] Postgress ingress

## Task-list: Extract source into GitHub

- [X] Book: Telling; BA Colley
- [X] Book: Cannon Becket; AH Colley
- [X] Book: All the Saints; AH Colley
- [X] Code: MicroNode assets
- [X] Code: BHC assets
- [X] Code: Archive/Backup search

## Task-list: Consolidate data

All media to be examined and processed:

- All information of interest on all media to go into iCloud
- All projects, including legacy and completed ones, into GitHub
- Sensitive data audit, and secure wipe where required
- Visible logical status labelling

- [ ] /home/${USER} directories on bare metal X 3
- [X] /media on james
- [X] thumb drives X 12
- [X] external hard drives X 1
- [X] 2.5" replaced hard drives X 3
- [X] 3.5" replaced hard drives X 2

### Media repurposing

- [X] 2.5" replaced hard drives X 3 - Install in james
- [X] 3.5" replaced hard drives X 2 - Install in external enclosures
