# Cilium

## Build on talos on venus

## Cilium install

- `helm repo add cilium https://helm.cilium.io/`
- `helm repo update`

```bash
helm template \
    cilium \
    cilium/cilium \
    --version 1.17.4 \
    --set hubble.relay.enabled=true \
    --set hubble.ui.enabled=true \
    --set ingressController.enabled=true \
    --set ingressController.loadbalancerMode=shared \
    --set ingressController.default=true \
    --set l2announcements.enabled=true \
    --set l2announcements.leaseDuration=3s \
    --set l2announcements.leaseRenewDeadline=1s \
    --set l2announcements.leaseRetryPeriod=200ms \
    --set loadBalancerIPs.enable=true \
    --set gatewayAPI.enabled=true \
    --set loadBalancer.l7.backend=envoy \
    --namespace kube-system \
    --set ipam.mode=kubernetes \
    --set kubeProxyReplacement=true \
    --set securityContext.capabilities.ciliumAgent="{CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,DAC_OVERRIDE,FOWNER,SETGID,SETUID}" \
    --set securityContext.capabilities.cleanCiliumState="{NET_ADMIN,SYS_ADMIN,SYS_RESOURCE}" \
    --set cgroup.autoMount.enabled=false \
    --set cgroup.hostRoot=/sys/fs/cgroup \
    --set k8sServiceHost=localhost \
    --set k8sServicePort=7445 > cilium.yaml
```

This enables:

- hubble, and hubble ui
- ingres controller, set to shared loadbalancer
- l2 announcements on loadbalancer IPs
- gateway api

Add IP pool:

```yaml
apiVersion: "cilium.io/v2alpha1"
kind: CiliumLoadBalancerIPPool
metadata:
  name: "ip-pool"
spec:
  blocks:
  - start: "192.168.4.90"
    stop: "192.168.4.90"
```

Add L2 announcement policy:

```yaml
apiVersion: "cilium.io/v2alpha1"
kind: CiliumL2AnnouncementPolicy
metadata:
  name: l2policy
spec:
  loadBalancerIPs: true
```

## Initial installation

- Install on talos
- Generate cilium manifest:
- For L2 announcements, and cilium ingress controller, set:
- externalIPs.enabled=true
- l2announcements.enabled=true
- ingressController.enabled=true
- ingressController.loadbalancerMode=shared
- kubeProxyReplacement=true
- l7Proxy=true
- ingressController.default=true
- envoyConfig.enabled=true
- loadBalancer.l7.backend=envoy
- ingressController.default=true

```bash
helm template \
    cilium \
    cilium/cilium \
    --version 1.16.5 \
    --namespace kube-system \
    --set ipam.mode=kubernetes \
    --set kubeProxyReplacement=true \
    --set externalIPs.enabled=true \
    --set l2announcements.enabled=true \
    --set ingressController.enabled=true \
    --set ingressController.loadbalancerMode=shared \
    --set l7Proxy=true \
    --set ingressController.default=true \
    --set envoyConfig.enabled=true \
    --set loadBalancer.l7.backend=envoy \
    --set securityContext.capabilities.ciliumAgent="{CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,DAC_OVERRIDE,FOWNER,SETGID,SETUID}" \
    --set securityContext.capabilities.cleanCiliumState="{NET_ADMIN,SYS_ADMIN,SYS_RESOURCE}" \
    --set cgroup.autoMount.enabled=false \
    --set cgroup.hostRoot=/sys/fs/cgroup \
    --set k8sServiceHost=localhost \
    --set k8sServicePort=7445 > cilium.yaml

kubectl apply -f cilium.yaml
```

- Create patch template with {proxy,disable cni, disable proxy, asocp, stub for cilium manifest}
- controlplane-patch-template.yaml:

```yaml
machine:
  env:
    https_proxy: http://192.168.3.1:3128/
cluster:
  clusterName: mercury01
  allowSchedulingOnControlPlanes: true
  network:
    cni:
      name: none
  proxy:
    disabled: true
  inlineManifests:
    - name: cilium
      contents: |
```

- Create a patch stub: `cp controlplane-patch-template.yaml patch.yaml`
- Add cilium manifest (with indentation): `sed -e 's/^/        /' cilium.yaml >> patch.yaml`
- Apply patch: `talosctl gen config talos-nocloud https://192.168.3.80:6443 --config-patch @patch.yaml`
- Place generated controlplane.yaml in `/var/lib/vz/snippets`
- Place generated `talosconfig` in `~/.talos` as `config` to bootstrap

## Usage on Proxmox

- Create 3 X VM {100,4,16}
- Add cloudinit drive
- Set cloudinit IP address
- Place generated controlplane.yaml in `/var/lib/vz/snippets`
- To set cloudinit file up for VM 1000: `qm set 1000 --cicustom user=local:snippets/controlplane.yaml`
- To bootstrap cluster: `talosctl bootstrap -n 192.168.3.80 -e 192.168.3.80`
- To get kubectl config for the cluster: `talosctl kubeconfig -n 192.168.3.80 -e 192.168.3.80`

## References

- <https://docs.cilium.io/en/latest/network/servicemesh/tls-termination/>
- <https://cilium.io/use-cases/gateway-api/>
- <https://docs.cilium.io/en/stable/network/lb-ipam/>
- <https://isovalent.com/blog/post/migrating-from-metallb-to-cilium/>
- <https://docs.cilium.io/en/stable/network/servicemesh/ingress/>
- <https://gateway-api.sigs.k8s.io/>
- <https://docs.cilium.io/en/v1.14/network/servicemesh/gateway-api/gateway-api/>
- <https://itnext.io/cilium-gateway-api-cert-manager-and-lets-encrypt-updates-cc730818cb17>