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


Redirect HTTP to HTTPS
```yaml
haproxy_redirect_http: true
```

HAProxy ports which allow network traffic
```yaml
haproxy_http_port: 80
haproxy_https_port: 443
haproxy_stats_port: 7111
```

TCP services
List of services which use TCP connections on k8s nodes and LB
```yaml
tcp_services: {}
```

Example
```yaml
tcp_services:
  - name: whoisd
    port: 43
    nodePort: 30043
```

HTTP and HTTPS check statuses
```yaml
haproxy_http_check_status: 200
haproxy_https_check_status: 401
```

Hosts names
```yaml
k8s_hosts: {}
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
