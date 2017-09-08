Ansible Role: Check readiness
=============================

This role install Readiness checking on Red Hat linux based systems.

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

Example Playbook
----------------

    - hosts: addons
      roles:
        - readiness

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
