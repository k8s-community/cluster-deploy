Ansible Role: Tool Chain
========================

This role install Network & System Tools on Redhat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

Install network tools.
```yaml
toolchain_install_net_tools: true
```

Install system tools.
```yaml
toolchain_install_system_tools: true
```

Install docker.
```yaml
toolchain_install_docker: true
```

Example Playbook
----------------

    - hosts:
        - master
        - node
        - build
      roles:
        - toolchain

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
