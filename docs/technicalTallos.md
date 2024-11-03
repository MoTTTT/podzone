# Tallos

## Prep


- On unix, need to first install brew dependencies: `sudo apt-get install build-essential procps curl file git`
- Then need to install brew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- Then talosctl: `/home/linuxbrew/.linuxbrew/bin/brew install siderolabs/tap/talosctl`
- Then you can use (or link to): `/home/linuxbrew/.linuxbrew/Cellar/talosctl/1.8.2/bin/talosctl`
- MacOS: Install Talosctl: `brew install siderolabs/tap/talosctl`

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

- <https://www.talos.dev/v1.8/introduction/prodnotes/>
- <https://factory.talos.dev/?arch=amd64&cmdline-set=true&extensions=-&extensions=siderolabs%2Fiscsi-tools&extensions=siderolabs%2Fqemu-guest-agent&platform=nocloud&target=cloud&version=1.8.2>
- <https://www.talos.dev/v1.8/talos-guides/install/virtualized-platforms/proxmox/>
- <https://www.talos.dev/v1.8/talos-guides/install/cloud-platforms/nocloud/>