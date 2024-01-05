# Persistent data

Original cluster external storage used an nfs server, which represents a single point of failure, and is replaced with a Ceph cluster. In addition, there are unsolved issues with postgres and Opensearch using NFS as a storage class, specifically failing on chown operations.

We use the Canonical MicroSeph distribution of Ceph, and build a cluster using the hosts `sigiriya`, `james`, and `bukit`.

Before starting, check that the ubuntu installations have allocate sufficient space for the root filesystem. I found that only 100G of a 2TB drive was assigned to the root logical volume, which caused ceph cluster failure because the OS disk was above 80%.

## Preparation

To resize root partition to use all of the available space:

- To display volume information: `sudo vgdisplay``
- To extend the logical volume for the root partition: `lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv`
- To resize the root partition: `resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv`

## Installing microceph

- On all hosts in the cluster, install MicroCeph: `sudo snap install microceph`
- On Sigiriya (the master), bootstrap: `sudo microceph cluster bootstrap`
- To prep to add james: `sudo microceph cluster add james`
- This provides a key to be used on James, where we run: `sudo microceph cluster join <token>`
- Similarly, to add bukit, on Sigiriya, run: - `sudo microceph cluster add bukit`
- On Bukit `sudo microceph cluster join <token>`
- Next create (where using loopback volumes) and add disks
- To create a loopback disk:

```bash
  #!/bin/bash
  loop_file="$(sudo mktemp -p /mnt XXXX.img)"
  sudo truncate -s 60G "${loop_file}"
  loop_dev="$(sudo losetup --show -f "${loop_file}")"
  minor="${loop_dev##/dev/loop}"
  sudo mknod -m 0660 "/dev/sdib" b 7 "${minor}"
```

- Add a disk to each node in the cluster: `sudo microceph disk add --wipe "/dev/sdXX"`

Additional basic setups, for test cluster:

- `sudo microceph.ceph config set global osd_pool_default_size 2`
- `sudo microceph.ceph config set mgr mgr_standby_modules false`
- `sudo microceph.ceph config set osd osd_crush_chooseleaf_type 0`

### Installing the ceph dashboard

- To expose the dashboard over https, use the prod k8s Certificate Manager to get a certificate from LetsEncrypt, and create secret `ceph-cert`
- To extract it from k8s:
- `kubectl get secret ceph-cert -o json | jq -r '.data.["tls.key"]' | base64 -d >ceph.key`
- `kubectl get secret ceph-cert -o json | jq -r '.data.["tls.crt"]' | base64 -d >ceph.crt`
- To enable ceph dashboard: `sudo ceph mgr module enable dashboard`
- `sudo ceph dashboard set-ssl-certificate -i - < /home/colleymj/ceph/ceph.crt`
- `sudo ceph dashboard set-ssl-certificate-key -i - < /home/colleymj/ceph/ceph.key`
- Add a user: `echo <> |sudo ceph dashboard ac-user-create colleymj -i - administrator`
- Get endpoint dashboard ULR: `sudo ceph mgr services`
- If there is an issue with the standard port: `sudo ceph config set mgr mgr/dashboard/ssl_server_port 8081`
- Or the host: `ceph config set mgr mgr/dashboard/server_addr 192.168.0.6`

## Connecting microk8s to the ceph cluster

- NOTE: A single node k8s cluster required 4GB RAM and 4 CPUs, else did not complete installation
- NOTE: "Before enabling the rook-ceph addon on a strictly confined MicroK8s, make sure the rbd kernel module is loaded with `sudo modprobe rbd`." :
- Configure microk8s cluster:`sudo microk8s enable rook-ceph`
- We can now connect the k8s cluster to external storage
- We need ceph.conf, and ceph.keyring to attach, which can be found in the microceph snap directory: `/var/snap/microceph/current/conf`
- Using config and key: `sudo microk8s connect-external-ceph --ceph-conf ceph.conf --keyring ceph.keyring --rbd-pool southcluster_rbd`

## Some ceph CLI commands

- `sudo microceph status`
- `sudo microceph cluster config get cluster_network`
- `sudo microceph cluster config list`
- `sudo microceph cluster list`
- `sudo microceph disk list`
- `sudo microceph.ceph status`

## Ceph References for FS

- <https://docs.ceph.com/en/quincy/cephfs/createfs/>
- <https://github.com/rook/rook/blob/master/deploy/examples/filesystem.yaml>
- <https://rook.io/docs/rook/latest/CRDs/Cluster/external-cluster/>
- <https://rook.io/docs/rook/latest-release/Getting-Started/example-configurations/#shared-filesystem>