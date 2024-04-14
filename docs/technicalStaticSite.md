# Helm Charts

Kubernetes object specifications can be applied to the cluster manually using `kubectl`. However, as these objects increase in number, an abstraction above that of Kubernetes objects is useful, if not necessary. This is where helm plays a role, allowing sets of objects to be managed collectively, and provides a mechanism to externalise key aspects of configuration. This is achieved with a templating language, leaving the key configuration items isolated and aggregated. This in turn, together with a configuration value overriding facility, allows for the same package to be re-used with only the key configuration items requiring further management.

## static-site

The kubernetes objects required for a static site have been refactored into a dedicated github repo: <https://github.com/MoTTTT/static-site.git>

The helm chart has been published on [Cloudsmith](https://cloudsmith.com). It is available here: <https://cloudsmith.io/~q-solutions/repos/static-site/packages/>.

If anyone else has a similar requirement or use-case, then it would save a bit of work. I hope so, and welcome feedback.

## Helm Chart description

### Hardened Apache Web Server with git-sync, and LetsEncrypt certificate

The Helm Chart contains the following resources:

- clusterissuer.yaml: This sets up a config for the certificate requests. Set the `issuer` definition in values.yaml
- certificate.yaml: This sets up a certificate for the site. Set the `certificate` definition in values.yaml
- configmap.yaml: This loads a minimal `httpd.conf` file, with security hardening appropriate for a static site
- deployment.yaml: This spins up Apache, with a git-sync-sidecar, and uses the `httpd.conf` configmap
- service.yaml: This is a cluster internal endpoint that load balances requests to the pods in the deployment.
- ingress.yaml: This sets up an external endpoint, and routes requests to the Service. Set the `ingres` definition in values.yaml
- serviceaccount.yaml: Service Account for the deployment

## Prerequisites

- L2 load balancer (I am using metallb). The IP address specified needs to be noted for port forwarding
- Ingress (I am using <https://kubernetes.github.io/ingress-nginx>)
- Certificate Manager (I use the microk8s add-on package `microk8s enable cert-manager`)
- WAN port forwarding to the metallb IP address is required for certificates to be issued.

## Publishing and use of the helm chart

The helm chart is packaged using helm, and kindly hosted on Cloudsmith.

- To package the helm chart: `helm package ./static-site`
- To upload to CloudSmith: `cloudsmith push helm q-solutions/static-site static-site-0.1.X.tgz`

The package is now available as: <https://dl.cloudsmith.io/public/q-solutions/static-site/helm/charts/>.

The default chart deploys the <https://musings.thruhere.net> site, and is deployed as release `musings-01` as follows:

```bash
helm  install musings-01 --debug  --namespace musings --create-namespace static-site --repo 'https://dl.cloudsmith.io/public/q-solutions/static-site/helm/charts/'
```

Using a values file overriding details like dns name, and source git repo, the second static site is deployed as release `podzone-01`:

```bash
helm  install podzone-01 --debug  --namespace podzone --create-namespace static-site --repo 'https://dl.cloudsmith.io/public/q-solutions/static-site/helm/charts/' --values valuespodzone.yaml
```

The valuespodzone.yaml file looks like this:

```yaml
# Override defaults from qapps for podzone site.
# Values for podzone
certificate:
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
  className: "nginx"
  hosts:
  - host: docs.podzone.net
    paths:
      - path: /
        pathType: ImplementationSpecific
  tls:
    - secretName: podzone-cert
      hosts:
        - docs.podzone.net
test:
  url: "https://docs.podzone.net/index.html"
```

## Apache Hardening

The Apache server is a very capable and feature complete web server, serving or fronting over 10% of web and application resource installations. The default Apache configuration accommodates a broad set of web server use-cases, providing web server administrators considerable flexibility, and also the responsibility of first line defence. During initial testing, it was evident from request logs that some viewers were hostile. This was evident from the `.git` directory interest, and the expressed hope that a vulnerable wordpress site had been found.

The default configuration therefore represents an unnecessarily large attack surface. The specific requirements for the applications is narrow in scope. There is no need for directory listings. Nor are there any legitimate POST requests. This would be the case for most static sites, especially considering the typical microservice architecture, where api deployments can be distinct from the front-end functionality.

One of the reasons to share the final configuration is the possibility of improvement through feedback.

### Approach

- Extract default httpd.conf
- Disable unused modules
- Set minimum privileges on document root - no directory listings.
- Disable POST requests
- Apply best-practice hardening configurations (more about this can be found in references).

The final configuration file is as follows:

```conf
# httpd.conf for static-site

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

## To_Do

- The static-site V0.1.1 solution has a broader dependency: updating of Name Server entries for the site domains. Currently the installation has the support of a DynDns updater running on an unrelated host on the network. Adding an operator to handle this on the cluster, one for each site is required.
