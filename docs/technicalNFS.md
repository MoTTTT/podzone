# Deprecated

## Deprecated: NFS storage

A cluster-external NFS service is used to provide a Storage class for Persistent volume requirements, set up on sigiriya with access from `192.168.0.0/24`.

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

The following file in the config/ directory creates a general purpose storage class `nfs-csi`, and one specifically for the web site `apache-storage-class`:

- `podzone-pc-nfs.yaml`