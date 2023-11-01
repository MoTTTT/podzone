# Implementation Notes

## Decisions

- Microk8s Kubernetes distribution
- Build tools (kubectl, calicoctl, ansible etc) on dolmen workstation
- k8s IOT Edge on anasazi RPi
- Implement ceph distributed storage - Migrate from nfs on sigiriya
- Secure ingress host based routing

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
- Ubuntu Server and Desktop: `sudo snap install microk8s --channel=1.28/stable --classic`
- Ubuntu Core: `sudo snap install microk8s --channel=latest/edge/strict`
- If required to prevent deployment to RPi arch (e.g. Opensearch): `kubectl taint nodes levant key1=value1:NoSchedule`

## Cluster configuration

- `microk8s enable metrics-server`
- `microk8s enable rook-ceph`; See technicalCeph.md for more details
- `microk8s connect-external-ceph --ceph-conf ceph.conf --keyring ceph.keyring --rbd-pool dev_rbd`
- `microk8s connect-external-ceph --ceph-conf ceph.conf --keyring ceph.keyring --rbd-pool prod_rbd`
- `microk8s enable metallb`
- `microk8s enable cert-manager`
- `microk8s helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace`
- NOTE: This gives `ingressClassName: nginx`

## Infrastructure Test: musings over https with git-sync

- Test with apache over http, by applying the following
- ApacheService.yaml
- ApacheVolumeClaim.yaml
- Apache.yaml
- ApacheIngress.yaml
- Checkpoint: This should provide web solution at lbr IP address, and a certificate error on external access
- ClusterIssuer.yaml
- Certificates.yaml
- ApacheSecureIngress.yaml
