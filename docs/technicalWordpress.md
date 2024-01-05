# Installing Wordpress

## Using Kubeapps

- Pre-requisite: Install kubeapps
- Set up user info
- Set storage class
- Set service type to ClusterIP
- Set storageClass to ceph-rbd

## Using repo directly

- Reference: <https://github.com/bitnami/charts/tree/main/bitnami/wordpress>
- Repo GitHub: <https://bitnami.com/stack/wordpress/helm>
- Clone values file to `motttt-values.yaml`
- Install with: `helm  install motttt-01 --debug bitnami/wordpress --values motttt-values.yaml`
