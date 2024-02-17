# Database implementation

## Technology selection

- kubernetes db install
- postgres
- Server side tooling: adminer
- internet ingres to db port

## POC

- Reference: <https://jineshnagori.medium.com/ultimate-guide-to-setting-up-postgresql-in-kubernetes-with-statefulsets-adminer-dashboard-and-6232323cb4dc>
- Methodology for POC: kubernetes resource definitions in `QAppsCluster` local directory
- Hostname: adminer dbgui.dev.podzone.net
- Hostname: db on db.dev.podzone.net
- namespace: postgres-dev

### POC Notes

- Workspace: Create k8s resources in ~/QAppsCluster/DB

### Adminer

- `kubectl create namespace adminer`
- `kubectl apply --namespace adminer -f adminer-svc.yaml`
- `kubectl apply --namespace adminer -f adminer-deployment.yaml`
- `kubectl apply --namespace adminer -f adminer-ingress.yaml`

## References

- <https://jineshnagori.medium.com/ultimate-guide-to-setting-up-postgresql-in-kubernetes-with-statefulsets-adminer-dashboard-and-6232323cb4dc>
- <https://artifacthub.io/packages/helm/bitnami/postgresql>
- <https://github.com/bitnami/charts/tree/main/bitnami/postgresql-ha>
- <https://www.cncf.io/blog/2023/09/29/recommended-architectures-for-postgresql-in-kubernetes/>