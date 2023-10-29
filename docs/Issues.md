# Issues

## Zope

- Currently (and since before the 2016 install) zope comes bundled with plone
- Plone current installs Zope 4
- `Zope 4 is a successor to Zope 2.13, making many changes that are not backwards compatible with Zope 2.`
- Zope 2 still available, last updated 2010: <https://old.zope.dev/Products/Zope/folder_contents>
- Docker images for Zope 2 are available, e.g. <https://hub.docker.com/r/eeacms/zope-2-10-5>
- Check also <https://github.com/plone/cookiecutter-zope-instance>

## Opensearch

- Persistent data store issues: resolved by reproducing and fixing nfs issues externally
- `OpenSearch Dashboards server is not ready yet`
- `[opensearch-cluster-master-0] Not yet initialized (you may need to run securityadmin)`
- Cluster not starting up, all pods up
- High RAM utilisation, removing until workload is deployed.
- Tested with fluentd (microk8s enable community first)

### Levant architecture

```text
Fatal glibc error: This version of Amazon Linux requires a newer ARM64 processor compliant with at least ARM architecture 8.2-a with cryptographic extensions. 
On EC2 this is Graviton 2 or later.
```

- Prevent pod scheduling onto Levant `kubectl taint nodes levant key1=value1:NoSchedule`

### Persistent Storage permissions

```text
 Waiting for a volume to be created either by the external provisioner 'rook-ceph.rbd.csi.ceph.com' or manually by the system administrator. If volume creation is delayed, please verify that the provisioner is running and correctly registered.                                                 
```

```text
Warning  FailedScheduling  20s (x2 over 5m20s)  default-scheduler  0/1 nodes are available: 1 Insufficient cpu, 1 Insufficient memory. preemption: 0/1 nodes are available: 1 No preemption victims found for incoming pod..
```

- test: `sudo microk8s kubectl --namespace rook-ceph-external get cephcluster`

NOTE: This gave an error for so long that I thought it was not working. Also, csi-cephfsplugin-provisioner and csi-rbdplugin-provisioner deployments (still) show 0/2 ready...

While attempting to try to remove rook-ceph a few days later to retry from scratch, I got an error indicating that it was in use.

```text
colleymj@floresiensis:~$ sudo microk8s kubectl --namespace rook-ceph-external get cephcluster
NAME                 DATADIRHOSTPATH   MONCOUNT   AGE     PHASE       MESSAGE                          HEALTH        EXTERNAL   FSID
rook-ceph-external   /var/lib/rook     3          4d19h   Connected   Cluster connected successfully   HEALTH_WARN   true       717715ab-d64d-42fe-9219-486015d2c166
```

NFS:

```text
[2023-10-07T08:47:23,800][INFO ][o.o.s.OpenSearchSecurityPlugin] [opensearch-cluster-master-0] Disabled https compression by default to mitigate BREACH attacks. You can enable it by setting 'http.compression: true' in opensearch.yml
[2023-10-07T08:47:23,803][INFO ][o.o.e.ExtensionsManager  ] [opensearch-cluster-master-0] ExtensionsManager initialized 
[2023-10-07T08:47:23,825][ERROR][o.o.b.OpenSearchUncaughtExceptionHandler] [opensearch-cluster-master-0] uncaught exception in thread [main]
       org.opensearch.bootstrap.StartupException: OpenSearchException[failed to bind service]; nested: AccessDeniedException[/usr/share/opensearch/data/nodes];       
```

- PersistentVolumeCLaim error: `no persistent volumes available for this claim and no storage class is set`
- chown failure: `enableInitChown: false`

- Reproduce on direct nfs mount on dolmen, fine tuned /etc/exports with `all_squash`

### vm.max_map_count

- `[1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]`

- Temporary: `sysctl -w vm.max_map_count=262144`
- Permanent: Add `vm.max_map_count = 262144` to /etc/sysctl.conf

## Networking

- [X] Letsencrypt acme-challenge failing `"msg"="Certificate must be re-issued" "key"="default/qsolution-cert" "message"="Issuing certificate as Secret does not exist"`: Use helm ingress controller installation, nit `microk8s enable ingress`
- [X] Node IP Address not populating in ExternalIP for NodePort: Need to use MetalLB
- [X] ingress-nginx-controller calls out to `google.com`, `fingerprints.bablosoft.com`, `ip.bablosoft.com` and `api.ipify.org`
- [X] ingress-controller giving 404 error - not routing requests to back-end
- [X] Ingress controllers:
- [X] Helm install: `helm upgrade --install ingress-nginx ingress-nginx   --repo https://kubernetes.github.io/ingress-nginx   --namespace ingress-nginx - [X] create-namespace`
- [X] microk8s enable ingress: does not provision an ingress controller
- [X] <https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/aws/nlb-with-tls-termination/deploy.yaml>

```text
"Found valid IngressClass" ingress="default/cm-acme-http-solver-wrpsk" ingressclass="nginx" 
```

```text
E1028 11:53:50.833249       1 controller.go:210] cert-manager/challenges/scheduler 
"msg"="error scheduling challenge for processing" 
"error"="Operation cannot be fulfilled on challenges.acme.cert-manager.io 
"docs-cert-gfdzt-2136338773-280458000\": the object has been modified; please apply your changes to the latest version and try again"
"resource_kind"="Challenge"
"resource_name"="docs-cert-gfdzt-2136338773-280458000"
"resource_namespace"="kube-system"
"resource_version"="v1"           
```

``text
 I1028 12:01:23.238457       1 conditions.go:95] Setting lastTransitionTime for Issuer "test-selfsigned" condition "Ready" to 2023-10-28 12:01:23.23844713 +0000 UTC m=+83.454686327
 I1028 12:01:23.267715       1 conditions.go:201] Setting lastTransitionTime for Certificate "selfsigned-cert" condition "Ready" to 2023-10-28 12:01:23.267706439 +0000 UTC m=+83.483945638
 I1028 12:01:23.270382       1 trigger_controller.go:200] cert-manager/certificates-trigger "msg"="Certificate must be re-issued" "key"="cert-manager-test/selfsigned-cert" 
       "message"="Issuing certificate as Secret does not exist" "reason"="DoesNotExist"
 I1028 12:01:23.270444       1 conditions.go:201] Setting lastTransitionTime for Certificate "selfsigned-cert" condition "Issuing" to 2023-10-28 12:01:23.270432979 +0000 UTC m=+83.486672175
 I1028 12:01:23.304273       1 controller.go:161] cert-manager/certificates-trigger "msg"="re-queuing item due to optimistic locking on resource" "key"="cert-manager-test/selfsigned-cert" 
       "error"="Operation cannot be fulfilled on certificates.cert-manager.io \"selfsigned-cert\": the object has been modified; please apply your changes to the latest version and try again"
 I1028 12:01:23.304474       1 trigger_controller.go:200] cert-manager/certificates-trigger "msg"="Certificate must be re-issued" "key"="cert-manager-test/selfsigned-cert" 
       "message"="Issuing certificate as Secret does not exist" "reason"="DoesNotExist"
 I1028 12:01:23.304500       1 conditions.go:201] Setting lastTransitionTime for Certificate "selfsigned-cert" condition "Issuing" to 2023-10-28 12:01:23.304495648 +0000 UTC m=+83.520734847
 E1028 12:01:23.448907       1 controller.go:137] cert-manager/issuers "msg"="issuer in work queue no longer exists" "error"="issuer.cert-manager.io \"test-selfsigned\" not found"
 E1028 12:01:23.615284       1 controller.go:166] cert-manager/certificates-key-manager "msg"="re-queuing item due to error processing" 
       "error"="secrets \"selfsigned-cert-\" is forbidden: unable to create new content in namespace cert-manager-test because it is being terminated" "key"="cert-manager-test/selfsigned-cert"


- 

- `https://askubuntu.com/questions/1316899/remove-node-from-microk8s-cluster`


## Raspberry Pi

- [X] Levant: microk8s on RPi (Ubuntu Server) not/intermittently supported:

```text
error: snap "microk8s" is not available on stable for
       this architecture (armhf) but exists on other
       architectures (amd64, arm64, ppc64el).
```

- [X] Levant: microk8s on RiPi (Ubuntu Core) intermittently supported:

```text
martinjcolley@levant:~$ snap install microk8s --channel=latest/edge/strict
error: snap "microk8s" requires classic confinement which is only available on classic systems
```

- [ ] Opensearch deploy fails to RPi arch: `kubectl taint nodes levant key1=value1:NoSchedule`

- [ ] Installing k3s on model 2B boards with ``

```text
[INFO]  systemd: Starting k3s
Job for k3s.service failed because a fatal signal was delivered causing the control process to dump core.
See "systemctl status k3s.service" and "journalctl -xeu k3s.service" for details.
colleymj@balin:~ $ curl -sfL https://get.k3s.io | sh -
```

colleymj@balin:~ $ uname -a
Linux balin 6.1.0-rpi4-rpi-v6 #1 Raspbian 1:6.1.54-1+rpt2 (2023-10-05) armv6l GNU/Linux

- <https://github.com/k3s-io/k3s/issues/4643>

## Dolmen

- [ ] Networking issues, probably caused by Cisco Anyconnect, see refs
