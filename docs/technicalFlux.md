# Flux

flux check --pre
export GITHUB_TOKEN=<your-token>
export GITHUB_USER=MoTTTT


- Using <https://github.com/MoTTTT/admin.git> repo

flux bootstrap github --token-auth --owner=MoTTTT --repository=admin --branch=main --path=clusters/ukdev --personal

flux bootstrap github --context=dev --owner=MoTTTT --repository=admin --branch=main --personal --path=clusters/dev --token-auth

flux uninstall

URL: https://motttt.github.io/charts/

flux create source git static-site \
  --url=https://github.com/MoTTTT/static-site \
  --branch=main \
  --interval=1m \
  --export > ./clusters/ukdev/static-site-source.yaml

flux create kustomization musings \
  --target-namespace=musings \
  --source=static-site \
  --path="./kustomize" \
  --prune=true \
  --wait=true \
  --interval=30m \
  --retry-interval=2m \
  --health-check-timeout=3m \
  --export > ./clusters/ukdev/musings-kustomization.yaml

 flux reconcile helmrelease musings --reset

- <https://github.com/fluxcd/flux2-multi-tenancy>



flux create source git podinfo \
  --url=https://github.com/stefanprodan/podinfo \
  --branch=master \
  --interval=1m \
  --export > ./clusters/my-cluster/podinfo-source.yaml


  For libretime


helm repo add k8s-at-home https://k8s-at-home.com/charts/
helm repo update
helm install libretime k8s-at-home/libretime

brew tap weaveworks/tap
brew install weaveworks/tap/gitops

## Resources created by flux

Can be seen on delete: `flux uninstall`

```text
martincolley@Dolmen:~/workspace/admin/clusters/ukdev$ flux uninstall
Are you sure you want to delete Flux and its custom resource definitions: y
► deleting components in flux-system namespace
✔ Deployment/flux-system/helm-controller deleted 
✔ Deployment/flux-system/kustomize-controller deleted 
✔ Deployment/flux-system/notification-controller deleted 
✔ Deployment/flux-system/source-controller deleted 
✔ Service/flux-system/notification-controller deleted 
✔ Service/flux-system/source-controller deleted 
✔ Service/flux-system/webhook-receiver deleted 
✔ NetworkPolicy/flux-system/allow-egress deleted 
✔ NetworkPolicy/flux-system/allow-scraping deleted 
✔ NetworkPolicy/flux-system/allow-webhooks deleted 
✔ ServiceAccount/flux-system/helm-controller deleted 
✔ ServiceAccount/flux-system/kustomize-controller deleted 
✔ ServiceAccount/flux-system/notification-controller deleted 
✔ ServiceAccount/flux-system/source-controller deleted 
✔ ClusterRole/crd-controller-flux-system deleted 
✔ ClusterRole/flux-edit-flux-system deleted 
✔ ClusterRole/flux-view-flux-system deleted 
✔ ClusterRoleBinding/cluster-reconciler-flux-system deleted 
✔ ClusterRoleBinding/crd-controller-flux-system deleted 
► deleting toolkit.fluxcd.io finalizers in all namespaces
✔ GitRepository/flux-system/flux-system finalizers deleted 
✔ Kustomization/flux-system/flux-system finalizers deleted 
► deleting toolkit.fluxcd.io custom resource definitions
✔ CustomResourceDefinition/alerts.notification.toolkit.fluxcd.io deleted 
✔ CustomResourceDefinition/buckets.source.toolkit.fluxcd.io deleted 
✔ CustomResourceDefinition/gitrepositories.source.toolkit.fluxcd.io deleted 
✔ CustomResourceDefinition/helmcharts.source.toolkit.fluxcd.io deleted 
✔ CustomResourceDefinition/helmreleases.helm.toolkit.fluxcd.io deleted 
✔ CustomResourceDefinition/helmrepositories.source.toolkit.fluxcd.io deleted 
✔ CustomResourceDefinition/kustomizations.kustomize.toolkit.fluxcd.io deleted 
✔ CustomResourceDefinition/ocirepositories.source.toolkit.fluxcd.io deleted 
✔ CustomResourceDefinition/providers.notification.toolkit.fluxcd.io deleted 
✔ CustomResourceDefinition/receivers.notification.toolkit.fluxcd.io deleted 
✔ Namespace/flux-system deleted 
✔ uninstall finished
```


## **Quarantine**

This chart contains a kubernetes trojan, deploying:

- dperson/openvpn-client
- ghcr.io/k8s-at-home/wireguard:v1.0.20210914
- codercom/code-server
- grafana/promtail
- nicolaka/netshoot

https://github.com/North14/helm-charts/releases/download/libretime-1.0.0/libretime-1.0.0.tgz

helm repo add north14 https://north14.github.io/helm-charts/
helm install my-libretime north14/libretime --version 1.0.0


flux create source git north14 \
  --url=https://north14.github.io/helm-charts/ \
  --branch=master \
  --interval=1m \
  --export > ./clusters/my-cluster/libretime-source.yaml

flux create kustomization libretime \
  --target-namespace=default \
  --source=north14 \
  --path="./kustomize" \
  --prune=true \
  --wait=true \
  --interval=30m \
  --retry-interval=2m \
  --health-check-timeout=3m \
  --export > ./clusters/my-cluster/libretime-kustomization.yaml




    patches:
    - patch: |-
        apiVersion: autoscaling/v2
        kind: HorizontalPodAutoscaler
        metadata:
          name: podinfo
        spec:
          minReplicas: 3             
      target:
        name: podinfo
        kind: HorizontalPodAutoscaler