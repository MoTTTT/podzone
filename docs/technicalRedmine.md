# Redmine

REGISTRY_NAME=registry-1.docker.io and REPOSITORY_NAME=bitnamicharts.

- `helm install my-release oci://REGISTRY_NAME/REPOSITORY_NAME/redmine`
helm install my-release oci://REGISTRY_NAME/REPOSITORY_NAME/redmine --set databaseType=postgresql

- <https://github.com/bitnami/charts/tree/main/bitnami/redmine/>


helm install --namespace projects --create-namespace  projects-01 oci://registry-1.docker.io/bitnamicharts/redmine --values values-projects.yaml