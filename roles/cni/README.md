Ansible Role: Container Network Interface plugin
================================================

This role install Container Network Interface plugin on Red Hat linux based systems.

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

Internal overlay network. It will assign IP
addresses from this range to individual pods.
This network must be unused block of space.
```yaml
k8s_cluster_cidr: 10.20.0.0/16
```

Kubernetes configs path
```yaml
k8s_conf_dir: /etc/kubernetes
```

CNI configs path
```
k8s_cni_dir: '{{ k8s_conf_dir }}/cni'
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

Romana version 
```yaml
k8s_romana_version: 2.0-preview.1
```

Calico version 
```yaml
k8s_calico_version: 2.4.1
```

Calico CTL version 
```yaml
k8s_calicoctl_version: 1.4.0
```

Flannel backend type (Options: gce, vxlan)
```yaml
k8s_flannel_backend: vxlan
```


Example Playbook
----------------

    - hosts:
        - master
        - node
      roles:
        - cni

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
