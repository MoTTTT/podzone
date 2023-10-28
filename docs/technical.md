# Implementation Notes

## Decisions

- Microk8s Kubernetes distribution
- Build tools (kubectl, calicoctl, ansible etc) on dolmen workstation
- k8s IOT Edge on anasazi RPi
- Implement ceph distributed storage - Migrate from nfs on sigiriya
- Secure ingress host based routing
- Migrate off all spinning disk

## Network

- Fibre router: Static IPs for control plane and worker nodes
- Fibre router: (As-is) Dynamic DNS for ```qsolutions.endoftheinternet.org```
- Fibre router: Port forwarding: 443 to k8s L2 load-balancer (As-is goes to dolmen)
- Fibre router: Restrict DHCP IP allocation range for clients to `192.168.0.2 - 192.168.0.120`
- MetalLB: IP address range: `192.168.0.131-192.168.0.140`
- DynDns: Add wildcard routes for all internet hosts in inventory, e.g. ```*.southern.podzone.net```
- DynDns: Update IP address using ddclient
- To dev, test and debug ingress, add: qapps.does-it.net

## Node installations

- For levant, to fix calico vxlan missing dependency: `sudo apt install linux-modules-extra-raspi`
- For RiPi: Add to /boot/firmware/cmdline.txt: `cgroup_enable=memory cgroup_memory=1 net.ifnames=1`
- Ubuntu Server and Desktop: `sudo snap install microk8s --classic`
- Ubuntu Core: `sudo snap install microk8s --channel=latest/edge/strict`
- If required to prevent deployment to RPi arch (e.g. Opensearch): `kubectl taint nodes levant key1=value1:NoSchedule`

## Cluster configuration

### Ingress configuration

MetalLB is used to implement an L2 load balancer. The metallb microk8s add-on is required:

- `sudo microk8s enable metallb`
- Production: Assign range: 192.168.0.131-192.168.0.132
- Dev: Assign range: 192.168.0.141-192.168.0.142

An ingress controller is required. De-facto standard seems to be ingress-nginx.

NOTE: Enabling the microk8s add-on failed to produce a working ingress for me, I believe because of namespace issues.

Load ingress-nginx using helm:
  
- `sudo microk8s helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace`
- `sudo microk8s kubectl --namespace ingress-nginx get services -o wide -w ingress-nginx-controller`

Per-host ingress configuration is applied via the kubernetes API. Configuration is per internet host in the inventory. For implementation details see the following files in config/ directory:

- `podzone-control-ingress.yaml`
- `podzone-dashboard-ingress.yaml`
- `podzone-musings-ingress.yaml`
- `podzone-plone-ingress.yaml`

### Certificate configuration

LetsEncrypt https certificates are used for https ingress. The CertificateManager add on is required.

- `sudo microk8s enable cert-manager`

For implementation details see the following files in config/ directory:

- `podzone-certificateIssuer.yaml`
- `podzone-certs.yaml`

### Upgrade: NOTE: did not result in rook-ceph add-on being available

- sudo microk8s disable dashboard
- microk8s disable metrics-server
- microk8s kubectl drain sigiriya --ignore-daemonsets
- sudo snap refresh microk8s --channel=1.28/stable
- microk8s kubectl uncordon sigiriya

### Application installation (to be automated)

For implementation details see the following files in config/ directory:

- web server: `podzone-apache.yaml``
- Plone: `podzone-plone.yaml``
- Git Sync: podzone-git-sync.yaml

### Supporting Infrastructure

- `sudo snap install prometheus`: Available on localhost:9090

### Opensearch

- Edit `https://github.com/opensearch-project/helm-charts/blob/main/charts/opensearch/values.yaml` for opensearch-bukit.yaml, opensearch-james.yaml, opensearch-sigiriya.yaml
- `helm repo add opensearch https://opensearch-project.github.io/helm-charts/`
- `helm install opensearch-master opensearch/opensearch -f opensearch-bukit.yaml`
- `helm install opensearch-client opensearch/opensearch -f opensearch-james.yaml`
- `helm install opensearch-data opensearch/opensearch -f opensearch-sigiriya.yaml`
- `helm install dashboards opensearch/opensearch-dashboards`

### Zope

- Initial install of Plone, provides Zope 4, which is not backward compatable with the Zope 2 applications, so use a legacy zope image.
- Zope volume mounts: ./var/filestorage; ./var/blobstorage; ./products
