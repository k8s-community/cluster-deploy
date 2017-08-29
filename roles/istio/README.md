Ansible Role: Istio 
===================

This role install Istio on Red Hat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

Log level 0 - debug
```yaml
k8s_log_level: 3
```

Use to increase verbosity on particular files, e.g. k8s_log_spec=token_controller*=5,other_controller*=4
```yaml
k8s_log_spec: ''
```

Istio version
```yaml
istio_version: 0.2.0
```

Conteiner Network Interface type, valid values: `calico`, `romana`
```yaml
cni_type: calico
```

Container Network Interface (CNI) bin path
```yaml
cni_bin_dir: /opt/cni/bin
```

Namespace for Istio
```yaml
k8s_istio_namespace: istio-system
```

It will be used as the Internal dns domain name if DNS is enabled.
Services will be discoverable under
`<service-name>.<namespace>.svc.<domainname>.<clustername>`, e.g.
myservice.default.svc.k8s.cluster
```yaml
k8s_domain_name: k8s
k8s_cluster_name: cluster
k8s_cluster_domain: '{{ k8s_domain_name }}.{{ k8s_cluster_name }}'
```

Kubernetes configs path
```yaml
k8s_conf_dir: /etc/kubernetes
k8s_istio_dir: '{{ k8s_conf_dir }}/istio'
```

Executable files path
```yaml
k8s_bin_dir: /usr/local/bin
```

Master hosts nsmes
```yaml
k8s_master_hosts: {}
```

Example Playbook
----------------

    - hosts: addons
      roles:
        - istio

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
