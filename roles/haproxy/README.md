Ansible Role: HAProxy balancer
==============================

This role install HAProxy balancer on Red Hat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):


HAProxy port used for stats
```yaml
haproxy_stats_port: 7111
```

HAProxy check attributes
```yaml
haproxy_check_interval: 5000
haproxy_check_rise: 3
haproxy_check_fall: 3
```

HAProxy services
List of services which use TCP connections on k8s nodes and LB
```yaml
haproxy_services: {}
```

Example
```yaml
haproxy_services:
  - name: node-80
    port: 80
    httpRedirect: true
  - name: node-443
    port: 443
    nodePort: 443
    httpCheck:
      path: /healthz
      status: 200
    sslProxy: true
  - name: whoisd
    port: 43
    nodePort: 30043
```

Hosts names
```yaml
haproxy_hosts: {}
```

SSL dir for haproxy 
```yaml
haproxy_ssl_dir: /etc/haproxy/ssl
```

SSL certificate and private key for running user services into Kubernetes
```yaml
k8s_services_cert: |
  ----BEGIN CERTIFICATE----
  - Your certificate here -
  -----END CERTIFICATE-----
k8s_services_cert_key: |
  ----BEGIN PRIVATE KEY----
  - Your private key here -
  -----END PRIVATE KEY-----
```


Example Playbook
----------------

    - hosts: master_lb
      roles:
        - haproxy

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
