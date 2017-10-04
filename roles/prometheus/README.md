Prometheus role
=========

This role installs Prometheus for Kubernetes cluster (endpoints, pods, nodes, istio, ...)

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.

Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

Prometheus version:
```yaml
k8s_prometheus_image_tag: v1.5.1
```
Domain name for prometheus (if it's empty so ingress object isn't created):
```yaml
k8s_prometheus_name: ''
```

Domain name for prometheus alert manager (if it's empty so ingress isn't created):
```yaml
k8s_prometheus_alertmanager_name: ''
```

Domain name for prometheus push gateway (if it's empty so ingress isn't created):
```yaml
k8s_prometheus_pushgateway_name: ''
```

New alerts
--------------

New alerts can be added in templates/alerts directory.

New scrape configs
--------------

New scrape configs can be added in templates/scrape_configs directory.

Example Playbook
----------------

    - hosts: addons
      roles:
        - prometheus

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)