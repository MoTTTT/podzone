#!/bin/bash
mkdocs build
apachepod=`kubectl get pods -n default -o json |jq -r .items[].metadata.name | grep apache`
echo Deploying to $apachepod
kubectl exec -n default $apachepod -- rm -R /var/www/html/podzone
kubectl -n default cp ~/workspace/podzone/site/ $apachepod:/tmp/podzone/
kubectl exec -n default $apachepod -- chown -R nobody:nogroup  /tmp/podzone/
kubectl exec -n default $apachepod -- mv /tmp/podzone  /var/www/html
