Ansible Role: Setup logrotate
======================

This role installs logrotate on Red Hat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.

Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

Example Playbook
----------------

    - hosts: master
      roles:
        - role: logrotate
          rotate_period: weekly
          rotate_count: 1

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
