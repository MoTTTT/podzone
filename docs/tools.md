# Tools

Tool and technology selection is influenced by server, workstation and admin client installed base.

Server infrastructure includes Mac and PC hardware, with Ubuntu OS installed. Server infrastructure is currently in use. Build of new software infrastructure will cohabit with existing software assets.
Redundant tooling will be removed as workload shifts to new software infrastructure.

Software distributions will therefore be chosen for Ubuntu OS packaging.

Initial build is manual, dev and subsequent releases are declarative.

## Distributions

- Kubernetes: Microk8s snap
- Ceph: MicroCeph snap
- Prometheus: snap

## Administration

- Kubernetes admin: kubectl (kubernetes-cli)
- Kubernetes Terminal UI: k9s
- Kubernetes Web UI (client side): octant
- CNI admin: calicoctl
- Database dashboard: adminer
- Monitoring: Prometheus
- Virtual Machine provisioning: Vagrant
- VM Configuration and microk8s cluster build: ansible
- Application release management: helm
- json processor: jq
- Terminal browser: midnight commander (mc)

## Additional components to be investigated

- Backup: Longhorn
- SSO: Dex