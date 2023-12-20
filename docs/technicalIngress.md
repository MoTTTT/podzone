# Ingress

```mermaid
---
title: southern.podzone.net Request Routing
---
graph TD

clientExt1 --> routerPort1
routerPort1 --> ovoo
lbr --> ingress

ingress -->|musings.thruhere.net| app1
ingress -->|qsolutions.endoftheinternet.org| app4
ingress -->|control.southern.podzone.net| app2
ingress -->|dashboard.southern.podzone.net| app3

  subgraph Internet
    clientExt1([Internet Client])
  end
  subgraph Router
    routerPort1[[port forward :443-> oovo:443]]
  end
  subgraph southern.podzone.net
 
    subgraph ovoo
      lbr{{lbr}}
    end
    ingress
    app1(apache)
    app4(zope)
    app2(k8s control plane)
    app3(k8s dashboard)

  end
```

## Ingress configuration

### L2 Load Balancer

MetalLB is used to implement an L2 load balancer. The metallb microk8s add-on is required:

- `sudo microk8s enable metallb`
- Production: Assign range: 192.168.0.131-192.168.0.132
- Dev: Assign range: 192.168.0.141-192.168.0.142

### Ingress Controller

An ingress controller is required. De-facto standard seems to be ingress-nginx.

Load ingress-nginx using helm:
  
- `sudo microk8s helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace`
- `sudo microk8s kubectl --namespace ingress-nginx get services -o wide -w ingress-nginx-controller`

NOTE: Enabling the microk8s add-on failed to produce a working ingress for me, not sure what I was doing wrong.

### Certificate Management

Enable the microk8s cert-manager, and define ClusterIssuer and Certificate requirements

- `sudo microk8s enable cert-manager`
- ClusterIssuer.yaml
- Certificates.yaml

### Ingress definition

Annotations link in the Certificate ClusterIssuer, and config to specify the hostname and tls secret. There is also an annotation to set the app-root.

- ApacheSecureIngress.yaml
