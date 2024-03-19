# Flux

- Using <https://github.com/MoTTTT/admin.git> repo

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