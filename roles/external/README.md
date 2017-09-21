Ansible Role: External Services
===============================

This role install External Services on Red Hat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

External services which can be outside of k8s cluster
```yaml
external_services: {}
```

Additional Kubernetes namespaces
```yaml
k8s_namespaces:
  - dev
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

    - hosts:
        - master
      roles:
        - external

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
