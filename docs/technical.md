# Implementation Notes

## Decisions

- Microk8s Kubernetes distribution
- Build tools (kubectl, calicoctl, ansible etc) on dolmen workstation
- k8s IOT Edge on anasazi RPi
- Implement ceph distributed storage - Migrate from nfs on sigiriya
- Secure ingress host based routing

## Network

- Fibre router: Static IPs for control plane and worker nodes
- Fibre router: (As-is) Dynamic DNS for ```qsolutions.endoftheinternet.org```
- Fibre router: Port forwarding: 443 to k8s L2 load-balancer (As-is goes to dolmen)
- Fibre router: Restrict DHCP IP allocation range for clients to `192.168.0.2 - 192.168.0.120`
- MetalLB: IP address range: `192.168.0.131-192.168.0.140`
- DynDns: Add wildcard routes for all internet hosts in inventory, e.g. ```*.southern.podzone.net```
- DynDns: Update IP address using ddclient
- To dev, test and debug ingress, add: qapps.does-it.net

## Node installations

- For levant, to fix calico vxlan missing dependency: `sudo apt install linux-modules-extra-raspi`
- For RiPi: Add to /boot/firmware/cmdline.txt: `cgroup_enable=memory cgroup_memory=1 net.ifnames=1`
- Ubuntu Server and Desktop: `sudo snap install microk8s --channel=1.28/stable --classic`
- Ubuntu Core: `sudo snap install microk8s --channel=latest/edge/strict`
- If required to prevent deployment to RPi arch (e.g. Opensearch): `kubectl taint nodes levant key1=value1:NoSchedule`

## Cluster configuration

- `microk8s enable metrics-server`
- `microk8s enable rook-ceph`; See technicalCeph.md for more details
- `microk8s connect-external-ceph --ceph-conf ceph.conf --keyring ceph.keyring --rbd-pool dev_rbd`
- `microk8s connect-external-ceph --ceph-conf ceph.conf --keyring ceph.keyring --rbd-pool prod_rbd`
- `microk8s enable metallb`
- `microk8s enable cert-manager`
- `microk8s helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace`
- NOTE: This gives `ingressClassName: nginx`

## Infrastructure Test: musings over https with git-sync

Initial kubernetes cluster and application functionality is tested using hand-coded kubernetes resources.

- Test with apache over http, by applying the following
- ApacheService.yaml
- ApacheVolumeClaim.yaml
- Apache.yaml
- ApacheIngress.yaml
- Checkpoint: This should provide web solution at lbr IP address, and a certificate error on external access
- ClusterIssuer.yaml
- Certificates.yaml
- ApacheSecureIngress.yaml

## Static site wrapper

There are two static sites in scope. Both require the following features:

- Leverage container storage class, provided by an external ceph cluster.
- Set up https certificates using LetsEncrypt
- Leverage L2 load-balancer and Internet ingress
- Pull the static content from a github repo
- Externalised Web server configuration for hardening without image build

The **kubernetes** resources and configuration for the musings site is wrapped using helm. The helm chart is packaged and kindly hosted on Cloudsmith.

Once the Cloudsmith account is created, a repo needs to be created, and the package can be uploaded through the web GUI.

A CLI is available for Cloudsmith, allowing a more automated approach.

To package and upload:

```bash
helm package ./qapps
cloudsmith push helm q-solutions/qapps qapps-0.1.1.tgz
```

The package is now available as: <https://dl.cloudsmith.io/public/q-solutions/qapps/helm/charts/>.

The default chart deploys musings.thruhere.net, and is deployed as follows:

```bash
helm  install orange-base --debug  --namespace musings qapps --repo 'https://dl.cloudsmith.io/public/q-solutions/qapps/helm/charts/'
```

A set of value overrides is applied to deploy the docs.podzone.net site, and is deployed as follows (with a values.yaml file in the current directory):

```bash
helm  install apple-base --debug  --namespace podzone qapps --repo 'https://dl.cloudsmith.io/public/q-solutions/qapps/helm/charts/' -f values.yaml --values values.yaml
```

Note the following:

- `orange-base` and `apple-base` are release names
- The name-spaces `musings` and `podzone` are used to keep resources separated, and need to pre-exist. e.g. `kubectl create namespace podzone`

The values.yaml file for the podzone site looks like this:

```yaml
# Override defaults from qapps for podzone site.
certificates:
  musings:
    name: podzone-cert
    dnsName: docs.podzone.net
gitsyncimage:
  args:
    - --repo=https://github.com/MoTTTT/podzone.git
    - --depth=1
    - --period=240s
    - --max-failures=10
    - --link=current
    - --root=/git-apache
    - --verbose=9
ingress:
  hosts:
  - host: docs.podzone.net
    paths:
      - path: /
        pathType: ImplementationSpecific
        backend:
          service:
            name: apache-service
            port:
              number: 80
  tls:
    - secretName: podzone-cert
      hosts:
        - docs.podzone.net
test:
  url: "https://docs.podzone.net/index.html"
```

## Hardening

### Hardening: Apache

- Extract default httpd.conf
- Disable unused modules
- Apply best-practice hardening configurations

The final configuration file is as follows:

```conf
# httpd.conf
# Apache configuration customised for qapps

# Modules critical for simple static site use-case
LoadModule mpm_event_module modules/mod_mpm_event.so
LoadModule access_compat_module modules/mod_access_compat.so
LoadModule reqtimeout_module modules/mod_reqtimeout.so
LoadModule mime_module modules/mod_mime.so
LoadModule log_config_module modules/mod_log_config.so
LoadModule headers_module modules/mod_headers.so
LoadModule unixd_module modules/mod_unixd.so
LoadModule dir_module modules/mod_dir.so
LoadModule authz_core_module modules/mod_authz_core.so

# Generic settings for qapps apache server component
ServerRoot "/usr/local/apache2"
Listen 80
ServerAdmin martinjcolley@gmail.com
<IfModule unixd_module>
    User www-data
    Group www-data
</IfModule>

# Document root set up to accommodate "current/site" content root provided by volume mapped git-sync directory
# Only request types required for static site access are allowed
# Indexes not generated where index.html file does not exist
DocumentRoot "/usr/local/apache2/htdocs/current/site"
<Directory "/usr/local/apache2/htdocs/current/site">
    Options -Indexes -Includes +FollowSymLinks
    AllowOverride None
    Require all granted
    <LimitExcept GET HEAD>
        deny from all
    </LimitExcept>
</Directory>

# Hardening:
# Prevent server detail leakages
# Set headers for best practice security
# Enable request time-out to prevent slow request denial of service
ServerTokens Prod
ServerSignature Off
FileETag None
TraceEnable off
Header edit Set-Cookie ^(.*)$ $1;HttpOnly;Secure
Header always append X-Frame-Options SAMEORIGIN
Header set X-XSS-Protection "1; mode=block"
Timeout 60
<IfModule dir_module>
    DirectoryIndex index.html
</IfModule>
<Files ".ht*">
    Require all denied
</Files>
<Directory />
    AllowOverride none
    Require all denied
</Directory>
<IfModule headers_module>
    RequestHeader unset Proxy early
</IfModule>

# Logging configuration
ErrorLog /proc/self/fd/2
LogLevel warn
<IfModule log_config_module>
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
    LogFormat "%h %l %u %t \"%r\" %>s %b" common
    <IfModule logio_module>
      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio
    </IfModule>
    CustomLog /proc/self/fd/1 common
</IfModule>

# Support for compression
<IfModule mime_module>
    TypesConfig conf/mime.types
    AddType application/x-compress .Z
    AddType application/x-gzip .gz .tgz
</IfModule>
```

## juju configuration

- `juju add-k8s prod --storage=ceph-rbd`
- `juju bootstrap prod`