Ansible Role: Kubernetes
========================

This role install Kubernetes common services on Redhat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):


Dependencies
------------

No dependensies.


Example Playbook
----------------

    - hosts:
        - master
        - node
      roles:
        - kubernetes

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
