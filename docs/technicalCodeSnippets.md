# Command line snippets

## Flux

flux bootstrap github --token-auth --owner=MoTTTT --repository=admin --branch=main --path=clusters/my-cluster --personal

## git

- Push cloned repo to personal account: $ git remote set-url origin http://github.com/YOU/YOUR_REPO

## microk8s

- sudo snap install microk8s --channel=1.28/stable --classic

## helm

- `helm repo add truecharts https://charts.truecharts.org/`
- `helm pull [chart URL | repo/chartname] [...] [flags]`
- `helm package static-site`
- `cloudsmith push helm q-solutions/static-site static-site-0.1.0.tgz`
- `helm  install musings-01 --debug  --namespace musings --create-namespace static-site --repo 'https://dl.cloudsmith.io/public/q-solutions/static-site/helm/charts/'`
- `helm install podzone-01 --debug --namespace podzone --create-namespace --values valuespodzone.yaml .`
- `helm  install podzone-01 --debug  --namespace podzone static-site --repo 'https://dl.cloudsmith.io/public/q-solutions/static-site/helm/charts/' -f values.yaml - --values valuespodzone.yaml`

## ceph

- sudo ceph config set mgr mgr/prometheus/server_addr sigiriya
- sudo ceph config set mgr mgr/prometheus/port 9090
- <https://docs.ceph.com/en/quincy/rados/operations/pools/#create-a-pool>
- mount.ceph name@07fe3187-00d9-42a3-814b-72a4d5e7d5be.fs_name=/ /mnt/mycephfs -o mon_addr=1.2.3.4
- sudo pro attach C13Nfcn8of2NLX4ZQbpN3zkEcT3WJZ
- Mount apple volume - `./apfs-fuse /dev/sdb2 /mt/sdb1`

## kubectl

- kubectl config set-context --current --namespace=<namespace-name>
- kubectl config set-context --current --namespace=admin
- kubectl drain --ignore-daemonsets <node name>
- kubectl uncordon <node name>
- kubectl get -n default serviceaccount kubeapps-operator -o yaml
- kubectl get pods --all-namespaces -o jsonpath="{..image}" | tr -s '[[:space:]]' '\n' | sort | uniq -c
- Aliases: `alias ka="kubectl apply -f "`; `alias kd="kubectl delete -f "`
- kubectl api-resources
- Install bash completion on mac: brew install bash-completion
- source /opt/homebrew/etc/bash_completion
- source <(kubectl completion bash) # set up autocomplete in bash into the current shell, bash-completion package should be installed first.
- echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.

## ansible

- `ansible southcluster -i inventory.yaml -m command -a "free -m"`
- To accept new ssh keys: `- ANSIBLE_HOST_KEY_CHECKING=false ansible all -m ping -i inventory.yaml`
- `ansible-playbook -i inventory.yaml playbook.yaml`
- `ansible-inventory -i inventory.yaml --list`
- `ansible devcluster -m ping -i inventory.yaml`
- `ansible-playbook -i inventory.yaml playbook-install-nfsclient.yaml`
- 
```text
- name: Install the package "foo"
  ansible.builtin.apt:
    name: foo
```

## apache

- enable site: a2ensite radio

- sudo systemctl restart apache2
- sudo apachectl configtest
- sudo apache2ctl -t

## plone

- `/usr/local/Plone/Python-2.7/bin/python /usr/local/Plone/zinstance/parts/instance/bin/interpreter /usr/local/Plone/buildout-cache/eggs/zdaemon-2.0.7-py2.7.egg/zdaemon/zdrun.py -S /usr/local/Plone/buildout-cache/eggs/Zope2-2.13.24-py2.7.egg/Zope2/Startup/zopeschema.xml -b 10 -d -s /usr/local/Plone/zinstance/var/instance/zopectlsock -x 0,2 -z /usr/local/Plone/zinstance/parts/instance /usr/local/Plone/Python-2.7/bin/python /usr/local/Plone/zinstance/parts/instance/bin/interpreter /usr/local/Plone/buildout-cache/eggs/Zope2-2.13.24-py2.7.egg/Zope2/Startup/run.py -C /usr/local/Plone/zinstance/parts/instance/etc/zope.conf
/usr/local/Plone/Python-2.7/bin/python`
- `/usr/local/Plone/zinstance/parts/instance/bin/interpreter`
- `/usr/local/Plone/buildout-cache/eggs/Zope2-2.13.24-py2.7.egg/Zope2/Startup/run.py -C /usr/local/Plone/zinstance/parts/instance/etc/zope.conf`
- `docker pull robcast/legacy-zope`
- `docker pull robcast/legacy-zope:2.13`

sudo usermod -aG sudo c

## Vagrant

vagrant init techchad2022/ubuntu2204
vagrant up
useradd -p <password> <username>
vagrant destroy


echo vagrant ALL=NOPASSWD:ALL > /etc/sudoers.d/vagrant
echo colleymj ALL=NOPASSWD:ALL > /etc/sudoers.d/colleymj

To allow IP to be assigned via DHCP simply use:
config.vm.network "public_network"
This way you don't need to deal with mac address, it will be generated on its own. If you need custom mac address attached to the network device then:
config.vm.network "public_network", :mac=> "080027xxxxxx"

## Network, wi-fi hot-spot

sudo nmcli connection add type bridge con-name 'Bridge' ifname bridge0
sudo nmcli connection add type ethernet slave-type bridge con-name 'Ethernet' ifname eth0 master bridge0
sudo nmcli connection add con-name 'Hotspot' ifname wlan0 type wifi slave-type bridge master bridge0 wifi.mode ap wifi.ssid Hotspot wifi-sec.key-mgmt wpa-psk wifi-sec.proto rsn wifi-sec.pairwise ccmp wifi-sec.psk 61519400
sudo nmcli connection add type ethernet slave-type bridge   con-name 'Ethernet' ifname eth0 master bridge0
sudo nmcli connection add con-name 'Hotspot'  \
   ifname wlan0 type wifi slave-type bridge master bridge0  \
   wifi.mode ap wifi.ssid Hotspot wifi-sec.key-mgmt wpa-psk  \
   wifi-sec.proto rsn wifi-sec.pairwise ccmp     wifi-sec.psk 61519400

sudo nmcli device wifi hotspot ssid podzone password xxx11111

sudo nmcli connection add con-name 'Hotspot' \
    ifname wlan0 type wifi slave-type bridge master bridge0 \
    wifi.mode ap wifi.ssid Hotspot wifi-sec.key-mgmt wpa-psk \
    wifi-sec.proto rsn wifi-sec.pairwise ccmp \
    wifi-sec.psk <hotspot-password>

## Volume management

Swap file: `dd if=/dev/zero of=/swapfile32G bs=1024 count=32M``
chmod 0600 swapfile32G
mkswap swapfile32G

dmsetup ls
sudo lvdisplay
lsblk --output NAME,KNAME,TYPE,SIZE,MOUNTPOINT
sudo dmsetup info ubuntu--vg-ubuntu--lv
lvdisplay
pvdisplay

raspberry pi set swapfile
sudo nano /etc/dphys-swapfile: set CONF_SWAPSIZE=2048
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start

## unix

usermod -a -G sudo colleymj

arp -n
ip link show
route
ip route show

ip link show
ifconfig | grep -m 1 "^[a-z0-9]*:" | sed -e's/\(^[a-z0-9]*\):.*$/\1/' | xargs -I {} sh -c "ethtool {}"
ifconfig | grep -m 1 "^[a-z0-9]*:" | sed -e's/\(^[a-z0-9]*\):.*$/\1/' | xargs -I {} sh -c "sudo tcpdump -i {}"

ip address show
ip route show
ss -tunap
sudo lsof -i @james

## Postgres

kubectl rollout status deployment/postgres
/mnt/vagrant-kubernetes 192.168.50.0/24(rw,sync,no_subtree_check,insecure,no_root_squash)

export QAPPS_PASSWORD="<password>"
envsubst < podzone-db.yaml | kubectl apply -f -

## Manual site updates

```bash
#!/bin/bash
mkdocs build
apachepod=`kubectl get pods -n default -o json |jq -r .items[].metadata.name | grep apache`
kubectl exec -n default $apachepod -- rm -R /var/www/html/podzone
kubectl -n default cp ~/workspace/podzone/site/ $apachepod:/tmp/podzone/
kubectl exec -n default $apachepod -- chown -R nobody:nogroup  /tmp/podzone/
kubectl exec -n default $apachepod -- mv /tmp/podzone  /var/www/html


kubectl exec apache-bf4996969-qnmqf -- rm -R /var/www/html/telling
kubectl cp ~/workspace/telling/site/ apache-bf4996969-qnmqf:/tmp/telling/
kubectl exec apache-bf4996969-qnmqf -- chown -R nobody:nogroup  /tmp/telling/
kubectl exec apache-bf4996969-qnmqf -- mv /tmp/telling  /var/www/html

kubectl cp ~/workspace/QApps/sites/index.html apache-bf4996969-qnmqf:/var/www.html/
```

## Command line completion

source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc

## Jenkinsx

Github token for jenkinsx: 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

kubectl create secret docker-registry regcred --docker-server=<docker-server> --docker-username=<username> --docker-password=<password> --docker-email=<email>

## Zope

Zope volume mounts:
./var/filestorage
./var/blobstorage
./products

kubectl cp ~/.factorio/saves/k8s-test.zip factorio/factorio-0:/factorio/saves/

kubectl cp ~/.factorio/saves/k8s-test.zip factorio/factorio-0:/factorio/saves/

### Upgrade: NOTE: did not result in rook-ceph add-on being available

- sudo microk8s disable dashboard
- microk8s disable metrics-server
- microk8s kubectl drain sigiriya --ignore-daemonsets
- sudo snap refresh microk8s --channel=1.28/stable
- microk8s kubectl uncordon sigiriya

### Opensearch

- Edit `https://github.com/opensearch-project/helm-charts/blob/main/charts/opensearch/values.yaml` for opensearch-bukit.yaml, opensearch-james.yaml, opensearch-sigiriya.yaml
- `helm repo add opensearch https://opensearch-project.github.io/helm-charts/`
- `helm install opensearch-master opensearch/opensearch -f opensearch-bukit.yaml`
- `helm install opensearch-client opensearch/opensearch -f opensearch-james.yaml`
- `helm install opensearch-data opensearch/opensearch -f opensearch-sigiriya.yaml`
- `helm install dashboards opensearch/opensearch-dashboards`

Opensearch dashboard:

 Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=opensearch-dashboards,app.kubernetes.io/instance=dashboards" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT

token=$(kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)  kubectl -n kube-system describe secret $token

kubectl logs --selector app=csi-nfs-controller -n kube-system -c nfs
kubectl logs --selector app=csi-nfs-node -n kube-system -c nfs

Observability has been enabled (user/pass: admin/prom-operator)

kubectl -n kube-system describe certificate kubernetes-dashboard-stg
kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kubernetes-dashboard:kubernetes-dashboard
kubectl -n kube-system logs -f $(kubectl -n kube-system get pods -l app=cert-manager -o jsonpath="{.items[0].metadata.name}") cert-manager
kube-system describe certificate kubernetes-dashboard-stg
kubectl logs  deployment/cert-manager  -n cert-manager
sudo microk8s kubectl describe secret -n kube-system microk8s-dashboard-token
kubectl logs podname -n namespace –all-containers=true
kubectl logs ingress-nginx-controller-7ddd87655-t2btf --all-containers --namespace ingress-nginx 
kubectl logs cert-manager-5d6bc46969-cqxnw -n cert-manager –all-containers=true
helm show values ingress-nginx --repo https://kubernetes.github.io/ingress-nginx
kubectl get L2Advertisement --all-namespaces -o yaml
kubectl get ipaddresspool --all-namespaces -o yaml
kubectl -n ingress-nginx get svc
kubectl describe pod cert-manager-5d6bc46969-xxxnt -n cert-manager
sudo microk8s kubectl config view --raw > $HOME/.kube/config
calicoctl --allow-version-mismatch  get node -o yaml

/Users/martincolley/workspace/Certs/qsolutions/{cert1.pem, chain1.pem, fullchain1.pem, privkey1.pem}

kubectl create secret tls nginxsecret --key /Users/martincolley/workspace/Certs/qsolutions/privkey1.pem --cert /Users/martincolley/workspace/Certs/qsolutions/fullchain1.pem

kubectl create configmap nginxconfigmap --from-file=nginx-default.conf

brew install calicoctl

grep -B 15 -A 15 IP_AUTODETECTION_METHOD /var/snap/microk8s/current/args/cni-network/cni.yaml

kubectl create ingress demo-localhost --class=nginx --rule="levant/*=demo:80"

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml

nmcli connection add type bridge con-name localbr ifname localbr ipv4.method manual ipv4.addresses 10.13.31.1/24

sudo microk8s kubectl config view --raw > $HOME/.kube/config
sudo usermod -a -G microk8s <username>

multipass launch --network en0 --network name=bridge0,mode=manual

kubectl cluster-info dump

kubectl get pods -n kube-system -o wide

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml

sudo crictl --runtime-endpoint unix:///var/run/containerd/containerd.sock ps -a
sudo crictl --runtime-endpoint unix:///var/run/containerd/containerd.sock ps -a | grep kube | grep -v pause
sudo kubeadm init --control-plane-endpoint bukit --config kubeadm-config.yaml

/snap/docker/2893/bin/containerd config default

For snap docker installation (bukit):
sudo kubeadm init --cri-socket unix:/run/snap.docker/containerd/containerd.sock --control-plane-endpoint bukit --dry-run

For apt docker installation (james):
sudo kubeadm init --control-plane-endpoint bukit --dry-run

--config kubeadm-config.yaml

systemctl enable kubelet.service

kubectl version --client

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
sudo sysctl --system

- Kubernetes host network IP range `--service-cluster-ip-range=192.168.0.128/25` in  `/var/snap/microk8s/current/args/kube-apiserver`
- `/var/snap/microk8s/current/args/cni-network/cni.yaml`
- edit `/var/snap/microk8s/current/args/kube-apiserver` and setting the following arguments:

```text
# /var/snap/microk8s/current/args/kube-apiserver
--advertise-address=10.10.10.10
--bind-address=0.0.0.0
--secure-port=16443
```
- CNI Pulgin: Calico, using 192.168.1.0/16: ```kubeadm init --pod-network-cidr=192.168.1.0/16```


Full docker stack, packaged by docker: ```sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin```

Just runc and containerd, packaged by ubuntu: ```apt-get -y install containerd```

Containerd configuration requirements:

- Enable cri plugin in /etc/containerd/config.toml (achieved by overwriting the default file config.toml)
- Set cgroup driver to Systemd
- Configure k8s sandbox image

The following achieves this:

```text
cat > /etc/containerd/config.toml <<EOF
[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
    SystemdCgroup = true
[plugins."io.containerd.grpc.v1.cri"]
  sandbox_image = "registry.k8s.io/pause:3.9"
EOF
```

Restart containerd: ```systemctl restart containerd```


- Init command: kubeadm init --config kubeadm-config.yaml

### Tasks: Cleanup to retdo kubeadm init

- kubectl drain <node name> --delete-emptydir-data --force --ignore-daemonsets
- kubeadm reset 
- kubectl delete node <node name>

- clean /etc/cni/net.d

