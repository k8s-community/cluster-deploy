Ansible Role: Addons
====================

This role install Kubernetes services on Redhat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

Conteiner Network Interface type, valid values: `calico`, `romana`
```yaml
cni_type: calico
```

Container Network Interface (CNI) bin path
```yaml
cni_bin_dir: /opt/cni/bin
```

Kubernetes master and services host names
```yaml
k8s_services_name: services.your-domain-name
```

Cockroach DB data dir
```yaml
k8s_cockroachdb_dir: /var/lib/cockroachdb
```

Cockroach DB volume and cache size
```yaml
k8s_cockroachdb_volume_size: 1Gi
k8s_cockroachdb_cache_size: 250Mb
```


Example Playbook
----------------

    - hosts: addons
      roles:
        - addons

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
