Ansible Role: User credentials
==============================

This role install Kubernetes user credentials on Red Hat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

It will be used as the Internal dns domain name if DNS is enabled.
Services will be discoverable under
`<service-name>.<namespace>.svc.<domainname>.<clustername>`, e.g. myservice.default.svc.k8s.cluster
```yaml
k8s_domain_name: k8s
k8s_cluster_name: cluster
k8s_cluster_domain: '{{ k8s_domain_name }}.{{ k8s_cluster_name }}'
```

Kubernetes master and services host names
```yaml
k8s_master_name: master.your-domain-name
```

SSL base certificate name
SSL folder and file names will use the same name
```yaml
ssl_name: kubernetes
```

Path to files with SSL certificates and keys
```yaml
ssl_dir: /etc/ssl/{{ ssl_name }}
```

URL scheme for kubernetes services
```yaml
k8s_url_scheme: https
```

Kubernetes service API port
```yaml
k8s_api_port: 443
```

Master hosts nsmes
```yaml
k8s_master_hosts: {}
```

Example Playbook
----------------

    - hosts:
        - master
        - node
        - build
      roles:
        - user

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
