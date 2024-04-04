# NFS storage

## Northern site

### Usecases

- radio

### Configuration

- dataserver: `sudo apt install nfs-kernel-server`
- dataserver: `sudo mkdir /Data01/nfs`
- dataserver: `sudo chmod go+w /Data01/nfs`
- dataserver /etc/exports: `/Data01/nfs *(rw,sync,no_subtree_check)`
- dataserver: `sudo exportfs -a`
- rudolfensis (test): `sudo apt install nfs-common`
- rudolfensis (test) /etc/hosts: `192.168.1.26 dataserver`
- rudolfensis (test) /etc/fstab: `dataserver:/Data01/nfs /mnt/Data01-nfs nfs rsize=8192,wsize=8192,timeo=14,intr`
- rudolfensis (test): `sudo mount -a`
- rudolfensis (test): `df -H`: *dataserver:/Data01/nfs  2.1T  118G  1.8T   7% /mnt/Data01-nfs*
- k8s nodes: use ansible to `sudo apt install nfs-common`
- k8s cluster: use flux to install `csi-driver-nfs` helm chart

### flux install

- helm chart source: <https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts>
- helm chart: `csi-driver-nfs`
- For `--set kubeletDir=/var/snap/microk8s/common/var/lib/kubelet`, create a configmap

### Helm reference instructions

- `microk8s helm3 repo add csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts`
- `microk8s helm3 install csi-driver-nfs csi-driver-nfs/csi-driver-nfs --namespace kube-system --set kubeletDir=/var/snap/microk8s/common/var/lib/kubelet`

Issue:

- Pod describe reports: `Warning  FailedMount  3m32s (x448 over 14h)  kubelet  MountVolume.SetUp failed for volume "pvc-1c0b7728-5ebd-4bb0-85ba-0f0877ab9080" : rpc error: code = Internal desc = mkdir /var/snap: read-only file system`

Attempting dynamic provisioning...

## Deprecated: original site

- `helm3 repo add csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts
microk8s helm3 repo update`
- `helm3 install csi-driver-nfs csi-driver-nfs/csi-driver-nfs --namespace kube-system --set kubeletDir=/var/snap/microk8s/common/var/lib/kubelet`
- `chmod -R 777 /srv/nfs`
- `chown -R nobody:nogroup /srv/nfs`
- Add volumes into /etc/exports:

```text
/srv/nfs      192.168.0.0/24(rw,all_squash,sync,no_subtree_check)
/srv/nfs/k8s  192.168.0.0/24(rw,all_squash,sync,no_subtree_check)
/srv/nfs/mac  192.168.0.0/24(rw,all_squash,sync,no_subtree_check)
/srv/nfs/apachesites  192.168.0.0/24(rw,all_squash,sync,no_subtree_check)
/srv/nfs/db  192.168.0.0/24(rw,all_squash,sync,no_subtree_check)
/srv/nfs/backup  192.168.0.0/24(rw,all_squash,sync,no_subtree_check)
```

The following file in the config/ directory creates a general purpose storage class `nfs-csi`, and one specifically for the web site `apache-storage-class`:  `podzone-pc-nfs.yaml`


A cluster-external NFS service is used to provide a Storage class for Persistent volume requirements, set up on sigiriya with access from `192.168.0.0/24`.


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
- 