# Kubespray

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform

terraform -install-autocomplete


- qm set 9001 --net0 virtio,bridge=vmbr0 --ipconfig0 ip=192.168.4.100/24,gw=192.169.4.1
- qm set 9001 --net1 virtio,bridge=vmbr1 --ipconfig1 ip=10.0.1.2/24,gw=10.0.1.1

```yaml
k8s_control_plane = [
  {
    "ip0" = "10.0.1.10"
    "memory" = 8192
    "name" = "vm-k8s-dev01-bladon-01-cp-01"
    "vcpus" = 4
  },
  {
    "ip0" = "10.0.1.11"
    "memory" = 8192
    "name" = "vm-k8s-dev01-bladon-01-cp-02"
    "vcpus" = 4
  },
  {
    "ip0" = "10.0.1.12"
    "memory" = 8192
    "name" = "vm-k8s-dev01-bladon-01-cp-03"
    "vcpus" = 4
  },
]
k8s_worker = [
  {
    "ip0" = "10.0.1.20"
    "memory" = 8192
    "name" = "vm-k8s-dev01-bladon-01-worker-01"
    "vcpus" = 4
  },
  {
    "ip0" = "10.0.1.21"
    "memory" = 8192
    "name" = "vm-k8s-dev01-bladon-01-worker-02"
    "vcpus" = 4
  },
  {
    "ip0" = "10.0.1.22"
    "memory" = 8192
    "name" = "vm-k8s-dev01-bladon-01-worker-03"
    "vcpus" = 4
  },
]
kubespray_host = [
  {
    "ip0" = "10.0.1.5"
    "memory" = 2048
    "name" = "vm-k8s-dev01-bladon-01-kubespray-01"
    "vcpus" = 2
  },
]

```

## Ansible

```bash
VENVDIR=kubespray-venv
KUBESPRAYDIR=kubespray
python3 -m venv $VENVDIR
source $VENVDIR/bin/activate
cd $KUBESPRAYDIR
pip install -U -r requirements.txt
```

## References

- <https://kubernetes.io/docs/setup/best-practices/cluster-large/>
- <https://kubespray.io/#/docs/ansible/ansible?id=installing-ansible>