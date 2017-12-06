Ansible Role: Core DNS
======================

This role install Core DNS on Red Hat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

It will be used as the Internal dns domain name if DNS is enabled.
Services will be discoverable under
`<service-name>.<namespace>.svc.<domainname>.<clustername>`, e.g.
myservice.default.svc.k8s.cluster
```yaml
k8s_domain_name: k8s
k8s_cluster_name: cluster
k8s_cluster_domain: '{{ k8s_domain_name }}.{{ k8s_cluster_name }}'
```

Kubernetes internal network for services.
Kubernetes services will get fake IP addresses from this range.
This range must not conflict with anything in your infrastructure. These
addresses do not need to be routable and must just be an unused block of space.
```yaml
k8s_services_network: 10.254.0.0/16
```

IP address of Kube DNS
It should be in range of services subnet
```yaml
k8s_cluster_dns: 10.254.0.10
```

Internal overlay network. It will assign IP
addresses from this range to individual pods.
This network must be unused block of space.
```yaml
k8s_cluster_cidr: 10.20.0.0/16
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

Example Playbook
----------------

    - hosts: master
      roles:
        - coredns

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
