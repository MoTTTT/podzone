# Issues

### Ceph dashboard issues

- Unsuccessful load balancer configuration, due to ceph redirect to active dashboard node

```xml
  <Proxy balancer://ceph>
    BalancerMember http://192.168.1.112:8080/
    BalancerMember http://192.168.1.113:8080/
    BalancerMember http://192.168.1.117:8080/
    ProxySet lbmethod=bytraffic
  </Proxy>
  ProxyPreserveHost on
  ProxyPass /  "balancer://ceph/"
  ProxyPassReverse /  "balancer://ceph/"
```

## ddclient

```text
[migrations] started
[migrations] no migrations found
usermod: no changes
───────────────────────────────────────

      ██╗     ███████╗██╗ ██████╗ 
      ██║     ██╔════╝██║██╔═══██╗
      ██║     ███████╗██║██║   ██║
      ██║     ╚════██║██║██║   ██║
      ███████╗███████║██║╚██████╔╝
      ╚══════╝╚══════╝╚═╝ ╚═════╝ 

   Brought to you by linuxserver.io
───────────────────────────────────────

To support LSIO projects visit:
https://www.linuxserver.io/donate/

───────────────────────────────────────
GID/UID
───────────────────────────────────────

User UID:    911
User GID:    911
───────────────────────────────────────

[custom-init] No custom files found, skipping...
Setting up watches.
Watches established.
[ls.io-init] done.
/run/s6/basedir/scripts/rc.init: line 76: -f /etc/ddclient/ddclient.conf: not found
Stream closed EOF for ddclient/ddclient01-76c5bc7c6d-5p922 (ddclient)

```

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
Name:          cephfs-pvc-registry
Namespace:     admin
StorageClass:  rook-cephfs
Status:        Pending
Volume:        
Labels:        <none>
Annotations:   volume.beta.kubernetes.io/storage-provisioner: rook-ceph.cephfs.csi.ceph.com
               volume.kubernetes.io/storage-provisioner: rook-ceph.cephfs.csi.ceph.com
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      
Access Modes:  
VolumeMode:    Filesystem
Used By:       <none>
Events:
  Type     Reason                Age               From                                                                                                             Message
  ----     ------                ----              ----                                                                                                             -------
  Normal   ExternalProvisioning  7s (x4 over 22s)  persistentvolume-controller                                                                                      Waiting for a volume to be created either by the external provisioner 'rook-ceph.cephfs.csi.ceph.com' or manually by the system administrator. If volume creation is delayed, please verify that the provisioner is running and correctly registered.
  Normal   Provisioning          6s (x6 over 22s)  rook-ceph.cephfs.csi.ceph.com_csi-cephfsplugin-provisioner-95fbd8485-fb9pw_69c2e6ae-38ed-45a2-970c-4723c7e3e6d0  External provisioner is provisioning volume for claim "admin/cephfs-pvc-registry"
  Warning  ProvisioningFailed    6s (x6 over 22s)  rook-ceph.cephfs.csi.ceph.com_csi-cephfsplugin-provisioner-95fbd8485-fb9pw_69c2e6ae-38ed-45a2-970c-4723c7e3e6d0  failed to provision volume with StorageClass "rook-cephfs": error getting secret rook-csi-cephfs-provisioner in namespace rook-ceph: secrets "rook-csi-cephfs-provisioner" not found
```

```text
2023-11-20T11:29:19.877413868Z csi-snapshotter W1120 11:29:19.877245       1 reflector.go:424] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: failed to list *v1.VolumeSnapshotContent: the server could not find the requested resource (get volumesnapshotcontents.snapshot.storage.k8s.io)
2023-11-20T11:29:19.877451041Z csi-snapshotter E1120 11:29:19.877305       1 reflector.go:140] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: Failed to watch *v1.VolumeSnapshotContent: failed to list *v1.VolumeSnapshotContent: the server could not find the requested resource (get volumesnapshotcontents.snapshot.storage.k8s.io)
2023-11-20T11:29:36.823050521Z csi-snapshotter W1120 11:29:36.822847       1 reflector.go:424] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: failed to list *v1.VolumeSnapshotClass: the server could not find the requested resource (get volumesnapshotclasses.snapshot.storage.k8s.io)
2023-11-20T11:29:36.823092729Z csi-snapshotter E1120 11:29:36.822917       1 reflector.go:140] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: Failed to watch *v1.VolumeSnapshotClass: failed to list *v1.VolumeSnapshotClass: the server could not find the requested resource (get volumesnapshotclasses.snapshot.storage.k8s.io)
2023-11-20T11:30:07.188915165Z csi-snapshotter W1120 11:30:07.188720       1 reflector.go:424] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: failed to list *v1.VolumeSnapshotClass: the server could not find the requested resource (get volumesnapshotclasses.snapshot.storage.k8s.io)
2023-11-20T11:30:07.188988621Z csi-snapshotter E1120 11:30:07.188779       1 reflector.go:140] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: Failed to watch *v1.VolumeSnapshotClass: failed to list *v1.VolumeSnapshotClass: the server could not find the requested resource (get volumesnapshotclasses.snapshot.storage.k8s.io)
2023-11-20T11:30:11.962789416Z csi-snapshotter W1120 11:30:11.962564       1 reflector.go:424] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: failed to list *v1.VolumeSnapshotContent: the server could not find the requested resource (get volumesnapshotcontents.snapshot.storage.k8s.io)
2023-11-20T11:30:11.962821763Z csi-snapshotter E1120 11:30:11.962645       1 reflector.go:140] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: Failed to watch *v1.VolumeSnapshotContent: failed to list *v1.VolumeSnapshotContent: the server could not find the requested resource (get volumesnapshotcontents.snapshot.storage.k8s.io)
2023-11-20T11:30:37.517657237Z csi-snapshotter W1120 11:30:37.517472       1 reflector.go:424] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: failed to list *v1.VolumeSnapshotClass: the server could not find the requested resource (get volumesnapshotclasses.snapshot.storage.k8s.io)
2023-11-20T11:30:37.517705067Z csi-snapshotter E1120 11:30:37.517544       1 reflector.go:140] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: Failed to watch *v1.VolumeSnapshotClass: failed to list *v1.VolumeSnapshotClass: the server could not find the requested resource (get volumesnapshotclasses.snapshot.storage.k8s.io)
2023-11-20T11:30:52.471136995Z csi-snapshotter W1120 11:30:52.470842       1 reflector.go:424] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: failed to list *v1.VolumeSnapshotContent: the server could not find the requested resource (get volumesnapshotcontents.snapshot.storage.k8s.io)
2023-11-20T11:30:52.471201513Z csi-snapshotter E1120 11:30:52.470918       1 reflector.go:140] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: Failed to watch *v1.VolumeSnapshotContent: failed to list *v1.VolumeSnapshotContent: the server could not find the requested resource (get volumesnapshotcontents.snapshot.storage.k8s.io)
2023-11-20T11:31:33.033589640Z csi-snapshotter W1120 11:31:33.033389       1 reflector.go:424] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: failed to list *v1.VolumeSnapshotContent: the server could not find the requested resource (get volumesnapshotcontents.snapshot.storage.k8s.io)
2023-11-20T11:31:33.033666055Z csi-snapshotter E1120 11:31:33.033451       1 reflector.go:140] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: Failed to watch *v1.VolumeSnapshotContent: failed to list *v1.VolumeSnapshotContent: the server could not find the requested resource (get volumesnapshotcontents.snapshot.storage.k8s.io)
2023-11-20T11:31:36.770477011Z csi-snapshotter W1120 11:31:36.770049       1 reflector.go:424] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: failed to list *v1.VolumeSnapshotClass: the server could not find the requested resource (get volumesnapshotclasses.snapshot.storage.k8s.io)
2023-11-20T11:31:36.770535799Z csi-snapshotter E1120 11:31:36.770202       1 reflector.go:140] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: Failed to watch *v1.VolumeSnapshotClass: failed to list *v1.VolumeSnapshotClass: the server could not find the requested resource (get volumesnapshotclasses.snapshot.storage.k8s.io)
2023-11-20T11:32:28.083071138Z csi-snapshotter W1120 11:32:28.082874       1 reflector.go:424] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: failed to list *v1.VolumeSnapshotContent: the server could not find the requested resource (get volumesnapshotcontents.snapshot.storage.k8s.io)
2023-11-20T11:32:28.083113470Z csi-snapshotter E1120 11:32:28.082932       1 reflector.go:140] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: Failed to watch *v1.VolumeSnapshotContent: failed to list *v1.VolumeSnapshotContent: the server could not find the requested resource (get volumesnapshotcontents.snapshot.storage.k8s.io)
2023-11-20T11:32:31.358857770Z csi-snapshotter W1120 11:32:31.358678       1 reflector.go:424] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: failed to list *v1.VolumeSnapshotClass: the server could not find the requested resource (get volumesnapshotclasses.snapshot.storage.k8s.io)
2023-11-20T11:32:31.358893226Z csi-snapshotter E1120 11:32:31.358733       1 reflector.go:140] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: Failed to watch *v1.VolumeSnapshotClass: failed to list *v1.VolumeSnapshotClass: the server could not find the requested resource (get volumesnapshotclasses.snapshot.storage.k8s.io)
2023-11-20T11:33:12.002229884Z csi-snapshotter W1120 11:33:12.002044       1 reflector.go:424] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: failed to list *v1.VolumeSnapshotClass: the server could not find the requested resource (get volumesnapshotclasses.snapshot.storage.k8s.io)
2023-11-20T11:33:12.002263360Z csi-snapshotter E1120 11:33:12.002089       1 reflector.go:140] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: Failed to watch *v1.VolumeSnapshotClass: failed to list *v1.VolumeSnapshotClass: the server could not find the requested resource (get volumesnapshotclasses.snapshot.storage.k8s.io)
2023-11-20T11:33:20.724244370Z csi-snapshotter W1120 11:33:20.724086       1 reflector.go:424] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: failed to list *v1.VolumeSnapshotContent: the server could not find the requested resource (get volumesnapshotcontents.snapshot.storage.k8s.io)
2023-11-20T11:33:20.724276979Z csi-snapshotter E1120 11:33:20.724140       1 reflector.go:140] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: Failed to watch *v1.VolumeSnapshotContent: failed to list *v1.VolumeSnapshotContent: the server could not find the requested resource (get volumesnapshotcontents.snapshot.storage.k8s.io)
2023-11-20T11:33:56.586826741Z csi-snapshotter W1120 11:33:56.586617       1 reflector.go:424] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: failed to list *v1.VolumeSnapshotClass: the server could not find the requested resource (get volumesnapshotclasses.snapshot.storage.k8s.io)
2023-11-20T11:33:56.586867349Z csi-snapshotter E1120 11:33:56.586700       1 reflector.go:140] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: Failed to watch *v1.VolumeSnapshotClass: failed to list *v1.VolumeSnapshotClass: the server could not find the requested resource (get volumesnapshotclasses.snapshot.storage.k8s.io)
2023-11-20T11:34:04.996189494Z csi-snapshotter W1120 11:34:04.995951       1 reflector.go:424] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: failed to list *v1.VolumeSnapshotContent: the server could not find the requested resource (get volumesnapshotcontents.snapshot.storage.k8s.io)
2023-11-20T11:34:04.996229187Z csi-snapshotter E1120 11:34:04.996024       1 reflector.go:140] github.com/kubernetes-csi/external-snapshotter/client/v6/informers/externalversions/factory.go:117: Failed to watch *v1.VolumeSnapshotContent: failed to list *v1.VolumeSnapshotContent: the server could not find the requested resource (get volumesnapshotcontents.snapshot.storage.k8s.io)
2023-11-20T11:31:54.700054085Z csi-provisioner I1120 11:31:54.699841       1 controller.go:1337] provision "admin/cephfs-pvc-registry" class "rook-cephfs": started
2023-11-20T11:31:54.700403345Z csi-provisioner I1120 11:31:54.700159       1 event.go:285] Event(v1.ObjectReference{Kind:"PersistentVolumeClaim", Namespace:"admin", Name:"cephfs-pvc-registry", UID:"ff51591c-3090-40df-9df7-6f7ba3ca08db", APIVersion:"v1", ResourceVersion:"3705014", FieldPath:""}): type: 'Normal' reason: 'Provisioning' External provisioner is provisioning volume for claim "admin/cephfs-pvc-registry"
2023-11-20T11:31:54.709752611Z csi-provisioner W1120 11:31:54.709502       1 controller.go:934] Retrying syncing claim "ff51591c-3090-40df-9df7-6f7ba3ca08db", failure 12
2023-11-20T11:31:54.709809356Z csi-provisioner E1120 11:31:54.709572       1 controller.go:957] error syncing claim "ff51591c-3090-40df-9df7-6f7ba3ca08db": failed to provision volume with StorageClass "rook-cephfs": error getting secret rook-csi-cephfs-provisioner in namespace rook-ceph: secrets "rook-csi-cephfs-provisioner" not found
2023-11-20T11:31:54.709836775Z csi-provisioner I1120 11:31:54.709618       1 event.go:285] Event(v1.ObjectReference{Kind:"PersistentVolumeClaim", Namespace:"admin", Name:"cephfs-pvc-registry", UID:"ff51591c-3090-40df-9df7-6f7ba3ca08db", APIVersion:"v1", ResourceVersion:"3705014", FieldPath:""}): type: 'Warning' reason: 'ProvisioningFailed' failed to provision volume with StorageClass "rook-cephfs": error getting secret rook-csi-cephfs-provisioner in namespace rook-ceph: secrets "rook-csi-cephfs-provisioner" not found
```

```text
apiVersion: v1
data:
  userID: Y3NpLXJiZC1wcm92aXNpb25lcg==
  userKey: QVFDM0hrUmxacGZCSFJBQWc1Y2RDaW9ZZmxxUUdGbURuMGE3Znc9PQ==
kind: Secret
metadata:
  creationTimestamp: "2023-11-02T22:12:09Z"
  name: rook-csi-rbd-provisioner
  namespace: rook-ceph-external
  resourceVersion: "2627"
  uid: 655bfcc6-eca4-41ce-a81d-e2668c327484
type: kubernetes.io/rook

```


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
