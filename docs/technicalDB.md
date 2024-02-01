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

- Create k8s resources in ~/QAppsCluster/DB
