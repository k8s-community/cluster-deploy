Ansible Role: Services Volumes
==============================

This role install Services Volumes on Red Hat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

Size of volume in Gb. That volume used by services
```yaml
k8s_services_volume: 30
```

Size of volume in Gb. That volume used for backups
```yaml
k8s_backup_volume: 30
```

Kubernetes configs path
```yaml
k8s_conf_dir: /etc/kubernetes
k8s_addons_dir: '{{ k8s_conf_dir }}/addons'
```

Services volumes host path
```yaml
k8s_services_dir: /var/lib/data
```

Backup volumes host path
```yaml
k8s_backup_dir: /var/lib/backup
```

Using of network storage
If network storage disabled will use local disk for every requested claim 
```yaml
network_storage: false
```

Kubernetes network persistent disk type, valid values: `gce`, `ceph`
TODO: AWS persistent disk `aws`
```yaml
network_storage_type: gce 
```

Ceph monitor port
```yaml
ceph_monitor_port: 6789
```

Storage hosts names
```yaml
k8s_storage_hosts: {}
```

Example Playbook
----------------

    - hosts: addons
      roles:
        - volumes

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
