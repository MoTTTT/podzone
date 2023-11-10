# Workstation config

The purpose of this page is to keep some track of software installations required for build, troubleshooting and administration of the solution. Some of the tools are described in the Tooling topic above, under *Administration*.

## Tooling

Tools installed on Dolmen for cluster build and management:

- ansible
- kubectl
- calicoctl
- k8s
- helm
- jq
- octant
- openssl
- vagrant

## Connectivity

```mermaid
---
title: southern.podzone.net On-premise workstation connectivity
---
graph TD
 
kubectl --- microk8sW2
calicoctl --- kubectl

k9s --- kubectl
ssh --- james
ssh --- sigiriya
ssh --- bukit
ssh --- anasazi
ssh --- levant

ansible --- ssh

      subgraph dolmen workstation
        kubectl
        calicoctl
        ssh
        k9s
        ansible
      end

      subgraph microk8s Cluster
        subgraph Control Plane
          subgraph james
            microk8sW2{{microk8s}}
          end
        end
        subgraph sigiriya
          microk8sW1{{microk8s}}
        end
        subgraph bukit
          microk8sC2{{microk8s}}
        end
      end
      
      subgraph k3s Cluster
        subgraph levant
          k3s1{{k3s}}
        end
        subgraph anasazi
          k3s2{{k3s}}
        end
      end
```

## Hardware configuration

- MacBook Pro
- Apple M1
- 16GB RAM
- macOs Ventura 13.5.2
