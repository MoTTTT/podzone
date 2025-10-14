# NFS storage

This section covers the setup and use of NFS volumes from a kubernetes cluster. Firstly an nfs server is set up, tested from a client, and then configured for ue in a kubernetes manifest.


## Routing through a bastion

- NFS server on 192.168.4.3 internal network
- NFS volumes: `/nfs/nfspool01, /nfs/nfspool02`
- For transport: `iptables -t nat -A PREROUTING -i wlp2s0 -p tcp --dport 2049 -j DNAT --to-destination 192.168.4.3:2049`
- For portmap: `iptables -t nat -A PREROUTING -i wlp2s0 -p tcp --dport 111 -j DNAT --to-destination 192.168.4.3:111`
- For client test, in /etc/fstab: `192.168.4.3:/nfs/nfspool01 /mnt/nfs-vm-venus nfs rsize=8192,wsize=8192,timeo=14,intr`
- For client test, in /etc/fstab: `192.168.4.3:/nfs/nfspool02 /mnt/nfs-vm-venus nfs rsize=8192,wsize=8192,timeo=14,intr`

## NFS Server

To prepare the NFS server for use, using the exported directory `/Data01/nfs` as an example:

- `apt install nfs-kernel-server`
- `mkdir /Data01/nfs`
- `chmod go+w /Data01/nfs`
- `chown -R nobody:nogroup /Data01/nfs`
- Add entry to /etc/exports: `/Data01/nfs *(rw,sync,no_subtree_check)`
- `exportfs -a`

## Client test (OS level)

To test the NFS server, set up a client machine similar to a kubernetes node (assuming the dataserver has IP address 192.168.1.26):

- Install client driver: `apt install nfs-common`
- /etc/fstab: `192.168.1.26:/Data01/nfs /mnt/Data01-nfs nfs rsize=8192,wsize=8192,timeo=14,intr`
- Mount all: `mount -a`
- To examine the mounted volume, use `df -H`, which for the setup above would be something like: `*192.168.1.26:/Data01/nfs  2.1T  118G  1.8T   7% /mnt/Data01-nfs*`

## Kubernetes client

### Dynamic Provisioning

Static provisioning is discussed below, but I could only get success with dynamic provisioning.

Dynamic Provisioning for NFS only requires the nfs-common package on k8s nodes: `sudo apt install nfs-common -y`

The following manifest snippet illustrates usage:

```yaml
apiVersion: apps/v1
kind: Deployment
...
spec:
...
  template:
...
    spec:
...
      containers:
        volumeMounts:
        - mountPath: /web
          name: radiovolume
          subPath: icecastweb
      initContainers:
...
        volumeMounts:
        - mountPath: /mnt
          name: radiovolume
          subPath: icecastweb
      volumes:
      - name: radiovolume
        nfs:
          path: /Data02/musoclub
          server: 192.168.1.26
```

## CSI Driver for static provisioning

An NFS CSI driver was first attempted, but application had showstopper issues.

- k8s nodes: use ansible to `sudo apt install nfs-common`
- k8s cluster: use flux to install `csi-driver-nfs` helm chart
- `helm3 repo add csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts`
- `microk8s helm3 repo update`
- `helm3 install csi-driver-nfs csi-driver-nfs/csi-driver-nfs --namespace kube-system --set kubeletDir=/var/snap/microk8s/common/var/lib/kubelet`
- `chmod -R 777 /srv/nfs`
- `chown -R nobody:nogroup /srv/nfs`
- Add volumes into /etc/exports, e.g `/srv/nfs      192.168.0.0/24(rw,all_squash,sync,no_subtree_check)`

### flux install

- helm chart source: <https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts>
- helm chart: `csi-driver-nfs`
- For `--set kubeletDir=/var/snap/microk8s/common/var/lib/kubelet`, create a configmap

### Issue

- Pod describe reports: `Warning  FailedMount  3m32s (x448 over 14h)  kubelet  MountVolume.SetUp failed for volume "pvc-1c0b7728-5ebd-4bb0-85ba-0f0877ab9080" : rpc error: code = Internal desc = mkdir /var/snap: read-only file system`
- Attempting dynamic provisioning...

## References

- <https://kubedemy.io/kubernetes-storage-part-1-nfs-complete-tutorial>
- <https://github.com/rancher/rancher/issues/4423>
- <https://discuss.kubernetes.io/t/use-nfs-for-persistent-volumes-on-microk8s/19035/31>
- <https://akomljen.com/kubernetes-persistent-volumes-with-deployment-and-statefulset/>
- <https://github.com/rancher/rancher/issues/4423>
- <https://docs.mirantis.com/mke/3.7/ops/deploy-apps-k8s/persistent-storage/use-nfs-storage.html>
- <https://kubernetes.io/docs/concepts/storage/persistent-volumes/>
- <https://kubernetes.io/docs/concepts/storage/volumes/>
- <https://ubuntu.com/server/docs/service-nfs>
- <https://hbayraktar.medium.com/how-to-setup-dynamic-nfs-provisioning-in-a-kubernetes-cluster-cbf433b7de29>
- <https://github.com/kubernetes-sigs/sig-storage-lib-external-provisioner>
- <https://github.com/kubernetes-sigs/nfs-ganesha-server-and-external-provisioner/blob/7027d6505a510673579c03db589bcb02cc8eda0b/charts/nfs-server-provisioner/README.md>
- <https://microk8s.io/docs/addon-nfs>
- <https://microk8s.io/docs/how-to-nfs>
