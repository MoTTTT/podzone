# Jam Radio FM Architecture

## POV

- Domain purchased for POV: jam.radio.fm
- Build libretime chart, revised to remove non http ingress
- Deploy to norham cluster, using flux, with values override

## Post installation configuration

### Libretime

- log in as admin:admin
- Set admin password
- Set Station logo
- Get player and schedule widget html for web site home page

### Ingress modifications

- `~/workspace/admin/working$ kubectl apply -f tcp-services-configmap.yaml`
- edit *ingress-nginx-ingress-nginx-controller*: `    - --tcp-services-configmap=ingress-nginx/tcp-services`

## Technical Architecture

```mermaid
---
title: jam.radio.fm Request routing
---
graph LR

Internet -- jam.radio.fm  --> router
router -- 80\n443 --> dmz
router -- 8001\n8002 --> metallb3
dmz -- 192.168.1.221 --> metallb3
metallb3 --> k8s07
metallb3 --> k8s08
metallb3 --> k8s09
metallb3 --> k8s10
metallb3[[norham]]
router[[Router]]
dmz{{rudolfensis}}
k8s07{{norham01}}
k8s08{{norham02}}
k8s09{{norham03}}
k8s10{{norham04}}
```

```mermaid
---
title: jam.radio.fm Component Diagram
---
graph LR
subgraph Dataserver
    nfs-service2[(/DATA2/radio/)]
end
subgraph Norham Cluster
  subgraph  Libretime
    WebGUI
    Schedule
    Users
    Library
    Input
    Broadcast
  end
  WebSite
end
console.jam.radio.fm --> WebGUI
input.jam.radio.fm --> Input
www.jam.radio.fm --> WebSite
Input --> Broadcast
Library --> Dataserver
WebGUI --- Library
WebGUI --- Schedule
WebGUI --- Users
Dataserver --> Input
Library --> Schedule --> Input
Broadcast --> WebSite
browser1{{Station User}} --> console.jam.radio.fm
client{{DJ}} --> input.jam.radio.fm
browser2{{Listeners}} --> www.jam.radio.fm
```

## POV URLS

- Wordpress site: <https://www.jam.radio.fm>
- Radio Station console: <https://console.jam.radio.fm>
- Icecast Server console: <https://broadcast.jam.radio.fm>
- DJ Ingress: input.radio.thruhere.net:8001
- Master Ingress: input.radio.thruhere.net:8002

## POC URLS

- Wordpress site: <https://www.radio.thruhere.net>
- Radio Station console: <https://console.thruhere.net>
- Icecast Server console: <https://radio.thruhere.net>
- DJ Ingress: <https://dj.radio.thruhere.net/>
- Master Ingress: <https://master.radio.thruhere.net/>
