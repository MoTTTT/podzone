# Prometheus Implementation Notes

## Server installation

- `sudo snap install prometheus`: Available on localhost:9090
- `nano /var/snap/prometheus/current/prometheus.yml`

```yaml
global:
  scrape_interval:     15s
  external_labels:
    monitor: 'podzone-monitor'
scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']
```

## Scraping ceph

- Enable ceph monitoring endpoints: `ceph mgr module enable prometheus`

Add to prometheus config (IP addresses are for prod cluster):

```yaml
  - job_name: 'microceph'
    scrape_interval: 15s
    static_configs:
    - targets: ['192.168.0.4:9283', '192.168.0.14:9283', '192.168.0.21:9283']
```
