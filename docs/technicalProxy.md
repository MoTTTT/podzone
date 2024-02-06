#  Reverse proxy

Not all ISP managed consumer broadband routers support L2 load balancing provided by metallb.

The UK site had this problem, and Internet research indicates that the ISP is not able to assist.

Options are to buy a replacement broadband router, or use a different loadbalancing solution.

The design chosen is to dedicate t530 to auxilary functions including a reverse proxy taking traffic from the router forwarded port, to the metallb listener on the k8s cluster.
```
<VirtualHost *:443>
  SSLProxyEngine on
  SSLProxyVerify none
  ProxyPreserveHost on
  ProxyPass /  https://192.168.1.220/
  ProxyPassReverse /  https://192.168.1.220/
  ProxyRequests Off
</VirtualHost>
<VirtualHost *:80>
  ProxyPreserveHost on
  ProxyPass /  http://192.168.1.220/
  ProxyPassReverse /  http://192.168.1.220/
  ProxyRequests Off
</VirtualHost>
```