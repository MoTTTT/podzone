# QApps Business Brief

## Business Brief: As-is

- Services include QApps Accounting, and line of business functions for property syndication, and property rental closed corporates.
- These are currently running in an Ubuntu VirtualBox client instance hosted on an Ubuntu host (bukit).
- Also running in the VirtualBox client is a mail server, serving a static email archive.
- An Apache server is running at OS level on the Ubuntu host, serving static web pages.
- The Ubuntu host runs on-premise, connected to the internet via a fibre router.
- The fibre router provides bukit with a static IP and port forwarding of https traffic on the dynamic WAN address to port 443 for the Apache server, and port 8080 for the Zope listener.
- The static email archive is not accessible from the Internet.
- The hostname "qsolutions.endoftheinternet.org" is resolved to the WAN address using ```DynDns```.
- ```Let's Encrypt``` is used as CA for the SSL certificate.
- Backups are stored on premise, distributed across hosts, with ad-hoc manual copy onto off-premise media
- Assets (various ownership and type, including images, videos, and documents) are stored on premise, distributed across hosts, with ad-hoc manual copy onto off-premise media

## Business Brief: To-be

- Consolidation of web apps and content
- Build Zope and Postgresql platform for legacy applications
- Build automated load of apps and data
- Consolidation of hardware and network solution, with secure external access, on current SA site.
- Local relocation of site to shared accommodation in SA
- On arrival in UK, build redundant site in temporary accommodation
- Local relocation of site to permanent accommodation in UK
- Distributed Storage for assets
- Backup storage to iCloud
- GitHub for config, docs and code
- Backup GitHub to Storage
- IoT Edge presence on each premise

### Consumer cloud definition

- No public cloud runtime (d1, d2) dependencies
- Use of Consumer (commodity) components:
  - Computing resources
  - Networking
  - Internet access
- On-premise access:
    - full storage
    - all services
- Off grid (Internet disconnected) viability for services
- Off-premise (internet facing) access:
    - storage sub-set
    - web
    - mail archive
    - solution administration

## MVP deliverables

Containerised Services:

- Zope
- Postgres
- Mail
- Apache

Operationalisation:

- Combine Zope and Apache traffic onto one listener
- Send DB backups to iCloud
- Remote admin: Secure external access
- Access cluster from tools on laptop client from internet

## Workload success criteria

- [X] https access from on site browser
- [X] https access from off site browser
- [X] Web: Browse static sites
- [X] Web: Download ebooks
- [ ] QApps application server: Generate and View accounting report, Add and view transaction.
- [ ] Mail: Access Medico-Legal mail archive from 3rd party mac client
