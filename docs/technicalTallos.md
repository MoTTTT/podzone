# Tallos

## Prep

### Infrastructure

- 100 GB root Disk (Assuming 6 k8s nodes maximum)
- 8 CPU
- 16GB RAM

## Talosctl client configuration

### unix

- On unix, need to first install brew dependencies: `sudo apt-get install build-essential procps curl file git`
- Then need to install brew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- Add brew to path: `alias brew="/home/linuxbrew/.linuxbrew/Homebrew/bin/brew"`
- Then talosctl: `brew install siderolabs/tap/talosctl`
- `alias talosctl="/home/linuxbrew/.linuxbrew/Homebrew/Cellar/talosctl/1.8.2/bin/talosctl"`
- Then you can use (or link to): `/home/linuxbrew/.linuxbrew/Cellar/talosctl/1.8.2/bin/talosctl`

- `alias talosctl='/home/linuxbrew/.linuxbrew/Homebrew/Cellar/talosctl/1.8.2/bin/talosctl --talosconfig=/home/colleymj/.talos/talosconfig'`

### MacOS

- Brew installed
- Install Talosctl: `brew install siderolabs/tap/talosctl`

## Configuration

- Sample <https://github.com/adampetrovic/home-ops/blob/main/kubernetes/bootstrap/talos/talconfig.yaml>
- 

### Configuration Process try #2

- `talosctl gen config k8s01 https://192.168.3.81:6443`
- `talosctl apply-config -n 192.168.3.81 --file controlplane-paaliaq.yaml --insecure`
- `talosctl bootstrap --nodes 192.168.3.81`
- `talosctl -n 192.168.3.81 containers`
- `talosctl gen config --name 192.168.3.81 --role controlplane --insecure`
- `talosctl apply-config -n 192.168.3.80 --file controlplane-tarvos.yaml --insecure`
- `talosctl apply-config -n 192.168.3.82 --file controlplane-ymir.yaml --insecure`
- `talosctl kubeconfig --nodes 192.168.3.81 --endpoints 192.168.3.81`

### Configuration

- `talosctl gen config k8s01 https://192.168.3.81:6443`
- Test: `talosctl -n 192.168.3.81 disks --insecure`

### Bootstrap

- `alias talosctl="talosctl --talosconfig=~/.talos/talosconfig"`

- `talosctl gen secrets -o secrets.yaml`
- `talosctl gen config --with-secrets secrets.yaml k8s01 192.168.3.81`

- `talosctl bootstrap --nodes 192.168.3.81 --endpoints 192.168.3.81 --talosconfig=./talosconfig`

## Networking

Use PXE for boot, with metadata service for per machine (MAC Address) configuration.

```bash
talos.config=https://metadata.service/talos/config?mac=${mac}
```

- KaaS GitOps: <https://github.com/kubebn/talos-proxmox-kaas>
- PXE: <https://www.talos.dev/v1.8/talos-guides/install/bare-metal-platforms/pxe/>
- For API access from lan: <https://github.com/muzahid-c/iptables-loadbalancer>
- <https://scalingo.com/blog/iptables>
- Flannel installs by default
- Options: <https://www.civo.com/blog/calico-vs-flannel-vs-cilium>
- <https://github.com/cilium/cilium>

## Cluster components

- <https://github.com/adampetrovic/home-ops/tree/main>
- <https://www.cloudraft.io/blog/making-kubernetes-simple-with-talos>
- <https://blog.devops.dev/talos-os-raspberry-fc5f327b7026>
- <https://kevinholditch.co.uk/2023/10/21/creating-a-kubernetes-cluster-using-talos-linux-on-xen-orchestra/>
- 

## Proxmox using cloud init

- 192.168.3.81  paaliaq

```bash
export CONTROL_PLANE_IP=192.168.3.81
# /home/linuxbrew/.linuxbrew/Cellar/talosctl/1.8.2/bin/talosctl gen config talos-nocloud https://$CONTROL_PLANE_IP:6443 --output-dir _out
talosctl gen config talos-nocloud https://$CONTROL_PLANE_IP:6443 --output-dir _out

mkdir -p iso
mv _out/controlplane.yaml iso/user-data
echo "local-hostname: controlplane-1" > iso/meta-data
cat > iso/network-config << EOF
version: 1
config:
   - type: physical
     name: eth0
     mac_address: "52:54:00:12:34:00"
     subnets:
        - type: static
          address: 192.168.3.81
          netmask: 255.255.255.0
          gateway: 192.168.3.1
EOF
cd iso && mkisofs -output cidata.iso -V cidata -r -J user-data meta-data network-config
```

Set static IP address, add kernel parameter:

ip=<client-ip>:<srv-ip>:<gw-ip>:<netmask>:<host>:<device>:<autoconf>

ip=192.168.3.80:8.8.8.8:192.168.3.1:255.255.255.0:tarvos:eth0:
ip=192.168.3.81:8.8.8.8:192.168.3.1:255.255.255.0:paaliaq:eth0:
ip=192.168.3.82:8.8.8.8:192.168.3.1:255.255.255.0:ymir:eth0:


```txt
Your image schematic ID is: dc7b152cb3ea99b821fcb7340ce7168313ce393d663740b791c36f6e95fc8586
customization:
    systemExtensions:
        officialExtensions:
            - siderolabs/iscsi-tools
            - siderolabs/qemu-guest-agent
First Boot
Options for the initial boot of Talos Linux on Nocloud:

Disk Image
https://factory.talos.dev/image/dc7b152cb3ea99b821fcb7340ce7168313ce393d663740b791c36f6e95fc8586/v1.8.2/nocloud-amd64.raw.xz
ISO
https://factory.talos.dev/image/dc7b152cb3ea99b821fcb7340ce7168313ce393d663740b791c36f6e95fc8586/v1.8.2/nocloud-amd64.iso
PXE boot (iPXE script)
https://pxe.factory.talos.dev/pxe/dc7b152cb3ea99b821fcb7340ce7168313ce393d663740b791c36f6e95fc8586/v1.8.2/nocloud-amd64
Initial Install
For the initial Talos Linux install (doesn't apply to disk image boot) put the following installer image to the machine configuration:
factory.talos.dev/installer/dc7b152cb3ea99b821fcb7340ce7168313ce393d663740b791c36f6e95fc8586:v1.8.2

Talos Linux Upgrade
Use the following image to upgrade Talos Linux on the machine:
factory.talos.dev/installer/dc7b152cb3ea99b821fcb7340ce7168313ce393d663740b791c36f6e95fc8586:v1.8.2
```

## References

- <https://www.talos.dev/v1.8/introduction/prodnotes/>
- <https://factory.talos.dev/?arch=amd64&cmdline-set=true&extensions=-&extensions=siderolabs%2Fiscsi-tools&extensions=siderolabs%2Fqemu-guest-agent&platform=nocloud&target=cloud&version=1.8.2>
- <https://www.talos.dev/v1.8/talos-guides/install/virtualized-platforms/proxmox/>
- <https://www.talos.dev/v1.8/talos-guides/install/cloud-platforms/nocloud/>
- <https://blog.devops.dev/talos-os-raspberry-fc5f327b7026>
- <https://www.civo.com/blog/calico-vs-flannel-vs-cilium>
- <https://cilium.io/>
- <https://www.cloudraft.io/blog/making-kubernetes-simple-with-talos>
- 