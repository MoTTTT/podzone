# Cilium

## Build on talos on venus

## Issues

- Installation of opensearch: `invalid: metadata.labels: Invalid value: \"opensearch-opensearch-dashboard-opensearch-dashboards-dashboards\": must be no more than 63 characters"`

## Cilium install

- `helm repo add cilium https://helm.cilium.io/`
- `helm repo update`

```bash
helm template \
    cilium \
    cilium/cilium \
    --version 1.18.1 \
    --set hubble.relay.enabled=true \
    --set hubble.ui.enabled=true \
    --set hubble.ui.baseUrl=/hubble/ \
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
- envoyConfig.enabled=true
- loadBalancer.l7.backend=envoy
- ingressController.default=true

## Final install

- Include GatewayAPI
- Enable Hubble relay and UI
- L2 announcement lease config
- Enable loadBalancerIPs
- Add to talos controlplane-patch.yaml
- Create patch template with {proxy,disable cni, disable proxy, asocp, stub for cilium manifest}
- Add `hubble.ui.baseUrl=/hubble/`
- Update to V1.18.1
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

```bash
helm template \
    cilium \
    cilium/cilium \
    --version 1.18.1 \
    --set hubble.relay.enabled=true \
    --set hubble.ui.enabled=true \
    --set hubble.ui.baseUrl=/hubble/ \
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
    --set k8sServicePort=7445  | sed -e 's/^/        /' >> talos/controlplane-patch.yaml
```

## Gateway

Example GatewayClass and Gateway, with TLS termination using cert-manager:

```yaml
---
apiVersion: gateway.networking.k8s.io/v1beta1
kind: GatewayClass
metadata:
  name: cilium
spec:
  controllerName: io.cilium/gateway-controller
---
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: cluster08
  namespace: kube-system
  annotations:
    cert-manager.io/cluster-issuer: lets-encrypt
spec:
  gatewayClassName: cilium
  listeners:
  - hostname: cluster08.podzone.cloud
    name: cluster08-podzone-cloud-http
    port: 80
    protocol: HTTP
  - hostname: cluster08.podzone.cloud
    name: cluster08-podzone-cloud-https
    port: 443
    protocol: HTTPS
    tls:
      mode: Terminate
      certificateRefs:
        - name: cluster08-secret
    allowedRoutes:
      namespaces:
        from: All
```

## References

- <https://docs.cilium.io/en/latest/network/servicemesh/tls-termination/>
- <https://cilium.io/use-cases/gateway-api/>
- <https://docs.cilium.io/en/stable/network/lb-ipam/>
- <https://isovalent.com/blog/post/migrating-from-metallb-to-cilium/>
- <https://docs.cilium.io/en/stable/network/servicemesh/ingress/>
- <https://gateway-api.sigs.k8s.io/>
- <https://docs.cilium.io/en/v1.14/network/servicemesh/gateway-api/gateway-api/>
- <https://itnext.io/cilium-gateway-api-cert-manager-and-lets-encrypt-updates-cc730818cb17>
- <https://blog.grosdouli.dev/blog/cilium-gateway-api-cert-manager-let's-encrypt>
- <https://github.com/cilium/cilium/blob/v1.18.1/install/kubernetes/cilium/values.yaml#L992>
- <https://cert-manager.io/docs/usage/gateway/>
