Ansible Role: Ingress controller
================================

This role install Ingress Controller on Red Hat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

Kubernetes load balancer type, valid values: `nginx`
TODO: load balancer `gce`, `haproxy`
```yaml
k8s_lb_type: nginx 
```

PROXY protocol for ingress
https://www.haproxy.com/blog/haproxy/proxy-protocol/
```yaml
k8s_ingress_proxy_protocol: false
```

Kubernetes configs path
```yaml
k8s_conf_dir: /etc/kubernetes
k8s_addons_dir: '{{ k8s_conf_dir }}/addons'
```

Master hosts nsmes
```yaml
k8s_master_hosts: {}
```

Node hosts nsmes
```yaml
k8s_node_hosts: {}
```

Example Playbook
----------------

    - hosts: addons
      roles:
        - ingress

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
