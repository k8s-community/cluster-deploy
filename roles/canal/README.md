Ansible Role: Canal
===================

This role install Canal Network Plugin on Redhat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

Flannel backend type (Options: gce, vxlan)
```yaml
k8s_flannel_backend: vxlan
```

Internal overlay network. It will assign IP
addresses from this range to individual pods.
This network must be unused block of space.
```yaml
k8s_cluster_cidr: 10.20.0.0/16
```

Calico version 
```yaml
k8s_calico_version: 2.4.1
```

Kubernetes configs path
```yaml
k8s_conf_dir: /etc/kubernetes
```

Canal configs path
```
k8s_canal_dir: '{{ k8s_conf_dir }}/canal'
```

Container Network Interface (CNI) bin & config path
```yaml
cni_bin_dir: /opt/cni/bin
cni_conf_dir: /etc/kubernetes/cni/net.d
```

Executable files path
```yaml
k8s_bin_dir: /usr/bin
```

Master hosts nsmes
```yaml
k8s_master_hosts: {}
```

Nodes hosts names
```yaml
k8s_node_hosts: {}
```


Example Playbook
----------------

    - hosts:
        - master
        - node
      roles:
        - canal

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
