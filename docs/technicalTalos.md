# Talos

## Prep

- Server: Mars with 32 CPU; 220 GB RAM; 2 X 1TB, 4 X 600GB Disk
- Server: Mercury with 32 CPU; 220 GB RAM; 2 X 1TB, 4 X 600GB Disk

### Test node infrastructure allocation

- 100 GB root Disk
- 4 CPU
- 16GB RAM

## Talosctl client configuration

### unix

- On unix, need to first install brew dependencies: `sudo apt-get install build-essential procps curl file git`
- Then need to install brew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- Add brew to path: `alias brew="/home/linuxbrew/.linuxbrew/Homebrew/bin/brew"`
- Then talosctl: `brew install siderolabs/tap/talosctl`
- `alias talosctl="/home/linuxbrew/.linuxbrew/Homebrew/Cellar/talosctl/1.9.1/bin/talosctl"`
- Then you can use (or link to): `/home/linuxbrew/.linuxbrew/Cellar/talosctl/1.9.1/bin/talosctl`
- `alias talosctl='/home/linuxbrew/.linuxbrew/Homebrew/Cellar/talosctl/1.9.1/bin/talosctl --talosconfig=/home/colleymj/.talos/talosconfig'`

### MacOS

- Brew installed
- Install Talosctl: `brew install siderolabs/tap/talosctl`

## Configuration

### Cluster02

Manually editing controlplane.yaml and worker.yaml files.

- Generate cluster config: `talosctl gen config cluster02 https://192.168.4.210:6443`
- Check the storage device to use: `talosctl -n 192.168.4.210 disks --insecure`
- Edit controlplane.yaml and worker.yaml files. Set IP address and storage devices.
- `talosctl apply-config --insecure --nodes 192.168.4.210 --file controlplane.yaml`
- `talosctl apply-config --insecure --nodes 192.168.4.211 --file worker.yaml`
- `talosctl --talosconfig=./talosconfig --nodes 192.168.4.211 -e 192.168.4.210 version`
- `talosctl bootstrap --nodes 192.168.4.210 --endpoints 192.168.4.210 --talosconfig=./talosconfig`
- `talosctl kubeconfig --nodes 192.168.4.210 --endpoints 192.168.4.210 --talosconfig=./talosconfig`
- `talosctl --nodes 192.168.4.210 --endpoints 192.168.4.210 health --talosconfig=./talosconfig`
- `talosctl --nodes 192.168.4.211 --endpoints 192.168.4.210 dashboard --talosconfig=./talosconfig`

### Cluster03

Using patches, with talos image supporting:

- QEMU guest agent
- DRDB, required for LinStore

```yaml
customization:
    systemExtensions:
        officialExtensions:
            - siderolabs/drbd
            - siderolabs/qemu-guest-agent
```

- `talosctl gen config cluster03 https://192.168.4.216:6443 --config-patch @patch.yaml`
- `talosctl apply-config --insecure --nodes 192.168.4.216 --file controlplane.yaml`

```yaml
machine:
  install:
    disk: /dev/vda
  kernel:
    modules:
      - name: drbd
        parameters:
          - usermode_helper=disabled
      - name: drbd_transport_tcp
  env:
    https_proxy: http://192.168.4.1:3128/
cluster:
  network:
    cni:
      name: none
  proxy:
    disabled: true
  allowSchedulingOnControlPlanes: true
```

### Configuration on Mars

- ProxMox: Load image into local-lvm: <https://factory.talos.dev/image/ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515/v1.8.2/nocloud-amd64.iso>
- Proxmox: Create VMs, with 4 CPU, 16 GB RAM, and 100 GB Disk, using talos nocloud-amd64.iso
- ProxMox: Add CloudInit drive, and set IP addresses *{192.168.4.100,192.168.4.101,192.168.4.103}*
- Generate cluster config: `talosctl gen config mars01 https://192.168.4.100:6443 --output-dir mars01`
- Modify generated `controlplane.yaml` file, and place in /var/lib/vz/snippets/controlplane.yaml (ensure that local-lvm supports snippets)
- Control plane: add config to CloudInit drive: `qm set $VMID --cicustom user=local:snippets/controlplane.yaml`
- Worker: config to CloudInit drive: `qm set $VMID --cicustom user=local:snippets/worker.yaml`
- Bootstrap cluster: `talosctl bootstrap -n 192.168.4.100`
- Get kubectl config: `talosctl kubeconfig -n 192.168.4.100 --endpoints 192.168.4.100`
- Create git repo *Mars*, token with admin privileges, export as GITHUB_TOKEN, with GITHUB_USER
- Bootstrap gitops: `flux bootstrap github --context=admin@mars01 --owner=MoTTTT --repository=mars --branch=main --personal --path=clusters/mars01 --token-auth=true`
- Add supporting infrastructure manifests in Mars repo: MetalLB; ingres-nginx; cert-manager;
- Add application manifests in Mars repo
- Get disk info: `talosctl -n 192.168.4.100,192.168.4.101,192.168.4.103 disks`

### controlplane.yaml deviations

- cilium

```yaml
cluster:
  network:
    cni:
      name: none
  proxy:
    disabled: true
  allowSchedulingOnControlPlanes: true
```

- proxy

```yaml
machine:
    env:
        https_proxy: http://192.168.3.1:3128/
```

talosctl gen config talos-nocloud https://192.168.30:6443 --config-patch @patch.yaml


### Installing OpenEBS (mercury)

- talosctl -e 192.168.3.80 -n 192.168.3.80 patch mc -p @openebs-patch.yaml
- OpenEBS patch: openebs-patch.yaml

```yaml
machine:
    sysctls:
        vm.nr_hugepages: "1024"
    nodeLabels:
        openebs.io/engine: mayastor
    kubelet:
        extraMounts:
            - destination: /var/local/openebs-openebs/
              type: bind
              source: /var/local/openebs-openebs/
              options:
                  - rbind
                  - rshared
                  - rw
```

- Installation - without flux

```bash
helm repo add openebs https://openebs.github.io/openebs
helm repo update
helm upgrade --install openebs \
  --create-namespace \
  --namespace openebs \
  --set engines.local.lvm.enabled=false \
  --set engines.local.zfs.enabled=false \
  --set mayastor.csi.node.initContainers.enabled=false \
  openebs/openebs
```

- Namespace labels

```yaml
pod-security.kubernetes.io/audit: privileged
pod-security.kubernetes.io/enforce: privileged
pod-security.kubernetes.io/warn: privileged
```

- Storage class openebs-hostpath: replicated across all nodes
- Storage class openebs-single-replica: hostpath PVCs that are not replicated

### Issues

- `path /var/local/openebs-openebs/localpv-hostpath/etcd/ does not exist`

## Networking

- Flannel installs by default

Use PXE for boot, with metadata service for per machine (MAC Address) configuration.

```bash
talos.config=https://metadata.service/talos/config?mac=${mac}
```

## Cluster components

- <https://github.com/adampetrovic/home-ops/tree/main>
- <https://www.cloudraft.io/blog/making-kubernetes-simple-with-talos>
- <https://blog.devops.dev/talos-os-raspberry-fc5f327b7026>
- <https://kevinholditch.co.uk/2023/10/21/creating-a-kubernetes-cluster-using-talos-linux-on-xen-orchestra/>

## References

- <https://www.talos.dev/v1.8/introduction/prodnotes/>
- <https://factory.talos.dev/?arch=amd64&cmdline-set=true&extensions=-&extensions=siderolabs%2Fiscsi-tools&extensions=siderolabs%2Fqemu-guest-agent&platform=nocloud&target=cloud&version=1.8.2>
- <https://www.talos.dev/v1.8/talos-guides/install/virtualized-platforms/proxmox/>
- <https://www.talos.dev/v1.8/talos-guides/install/cloud-platforms/nocloud/>
- <https://blog.devops.dev/talos-os-raspberry-fc5f327b7026>
- <https://www.civo.com/blog/calico-vs-flannel-vs-cilium>
- <https://cilium.io/>
- <https://www.cloudraft.io/blog/making-kubernetes-simple-with-talos>
- <https://github.com/adampetrovic/home-ops/blob/main/kubernetes/bootstrap/talos/talconfig.yaml>
- KaaS GitOps: <https://github.com/kubebn/talos-proxmox-kaas>
- PXE: <https://www.talos.dev/v1.8/talos-guides/install/bare-metal-platforms/pxe/>
- Options: <https://www.civo.com/blog/calico-vs-flannel-vs-cilium>
- <https://github.com/cilium/cilium>
