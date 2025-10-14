# Open EBS Container storage and CSI

## Installing OpenEBS (mercury)

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
- Issue: `path /var/local/openebs-openebs/localpv-hostpath/etcd/ does not exist`
