# Prometheus Implementation Notes

## Server installation

- `sudo snap install prometheus`: Available on localhost:9090
- `nano /var/snap/prometheus/current/prometheus.yml`

```yaml
global:
  scrape_interval:     15s # By default, scrape targets every 15 seconds.

  # Attach these labels to any time series or alerts when communicating with
  # external systems (federation, remote storage, Alertmanager).
  external_labels:
    monitor: 'codelab-monitor'

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # Override the global default and scrape targets from this job every 5 seconds.
    scrape_interval: 5s

    static_configs:
      - targets: ['localhost:9090']
```

## Scraping ceph

- Enable ceph monitoring endpoints: `ceph mgr module enable prometheus`

Add to prometheus config (IP addresses are for prod cluster):

```yaml
  - job_name: 'microceph'

    # Ceph's default for scrape_interval is 15s.
    scrape_interval: 15s

    # List of all the ceph-mgr instances along with default (or configured) port.
    static_configs:
    - targets: ['192.168.0.4:9283', '192.168.0.14:9283', '192.168.0.21:9283']
```
