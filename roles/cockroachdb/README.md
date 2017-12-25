Ansible Role: Cockroach DB
==========================

This role install Cockroach DB on Red Hat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

Kubernetes configs path
```yaml
k8s_conf_dir: /etc/kubernetes
k8s_addons_dir: '{{ k8s_conf_dir }}/addons'
```

Secure deployment (recommended for production)
```yaml
k8s_cockroachdb_secure: false
```

Enable/Disable privileged mode
It's useful if linux running with enforsing selinux mode
```yaml
k8s_cockroachdb_privileged: false
```

Namespace for Cocroach DB
```yaml
k8s_cockroachdb_namespace: default
```

Cockroach DB data dir
```yaml
k8s_cockroachdb_dir: /var/lib/cockroachdb
```

Cockroach DB volume and cache size
```yaml
k8s_cockroachdb_volume_size: 1Gi
k8s_cockroachdb_cache_size: 25%
k8s_cockroachdb_max_sql_memory: 25%
```

List of databases for backup
```yaml
k8s_cockroachdb_backup: {}
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
        - cockroachdb

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
