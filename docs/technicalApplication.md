# Application Build

## Platform requirement

- Zope Python based Application server
- Python Postgress driver
- Zope Postgres driver wrapper
- Postgress Database
- Database GUI

## Migration

Move ularu VM from bukit (to be recovered) to antecessor

1. Export VM in .ova format
1. Test on james (final target server)

### Importing VM on james

VBoxManage import UbuntuAppServerClean202401.ova --dry-run

VBoxManage import UbuntuAppServerClean202401.ova

VBoxManage list vms

VBoxManage startvm "Ubuntu App Server" --type headless

```text
Waiting for VM "Ubuntu App Server" to power on...
VBoxManage: error: Nonexistent host networking interface, name 'enp3s0f0' (VERR_INTERNAL_ERROR)
VBoxManage: error: Details: code NS_ERROR_FAILURE (0x80004005), component ConsoleWrap, interface IConsole
```

ip address show | grep enp

```text
2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    inet 192.168.0.14/24 metric 100 brd 192.168.0.255 scope global enp1s0
```

VBoxManage showvminfo "Ubuntu App Server"

VBoxManage modifyvm "Ubuntu App Server" --nic2 bridged --bridgeadapter1 enp1s0

Did not work, needed to change `<BridgedInterface name="enp1s0"/>` in /home/colleymj/VirtualBox VMs/Ubuntu App Server/Ubuntu App Server.vbox


```text
VBoxManage: error: AMD-V is disabled in the BIOS (or by the host OS) (VERR_SVM_DISABLED)
```

VBoxManage modifyvm "Ubuntu App Server" --cpus 1

VBoxManage modifyvm "Ubuntu App Server" --paravirtprovider none

## Dyn DNS

- sudo apt install ddclient
- user; qapps
- hosts: southern.podzone.net,musings.thruhere.net,qsolutions.endoftheinternet.org,docs.podzone.net,mottttspot.servegame.org,poc.endoftheinternet.org

## Data take-on

- Postgress export from legacy implementation
- Import into new Postgress instance

## Implementation

### Zope

- Initial install of Plone, provides Zope 4, which is not backward compatable with the Zope 2 applications, so use a legacy zope image.
- Legacy Zope image selected: `robcast/legacy-zope:2.13`

- Zope volume mounts: ./var/filestorage; ./var/blobstorage; ./products

### Postgres

- nfs not working for postgres volume, issues with chmod (as with OpenSearch)
- Use cluster-internal db GUI tool to avoid requirement to provide ingress for a database port.
