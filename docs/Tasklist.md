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
- [ ] Expose k8s API
- [ ] Applications and Services

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

- [ ] Consolidate assets into iCloud
- [ ] Extract source into GitHub
- [ ] Extract Zope zexp files and check in
- [ ] Containerise Zope, including application code and config
- [X] Consolidate Web sites

### Task Breakdown: Containerise Zope, including application code and config

- [X] Plone Service and Deployment
- [X] Plone ingress for qsolutions.endoftheinternet.org
- [X] Ingress rewrite rules for Zope Virtual Host Monster
- [ ] Plone ZPsycopgDA installation (containerInit?)
- [ ] Postgress Service and Deployment
- [ ] Postgress ingress?

## Task-list: Extract source into GitHub

- [X] Book: Telling; BA Colley
- [X] Book: Cannon Becket; AH Colley
- [X] Book: All the Saints; AH Colley
- [ ] Code: MicroNode assets
- [ ] Code: BHC assets
- [ ] Code: Archive/Backup search
