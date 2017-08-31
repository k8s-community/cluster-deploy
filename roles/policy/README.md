Ansible Role: Policy rules
==========================

This role install Policy rules on Red Hat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

Additional Kubernetes namespaces
```yaml
k8s_namespaces:
  - dev
```

Users access data
```yaml
k8s_admin_username: admin
k8s_release_username: release
k8s_guest_username: guest
```

Kubernetes configs path
```yaml
k8s_conf_dir: /etc/kubernetes
k8s_policy_dir: '{{ k8s_conf_dir }}/policy'
```

Master hosts nsmes
```yaml
k8s_master_hosts: {}
```

SSL base certificate name
SSL folder and file names will use the same name
```yaml
ssl_name: kubernetes
```

Path to files with SSL certificates and keys
```yaml
ssl_dir: /etc/ssl/kubernetes
```

SSL certificate and private key for running user services into Kubernetes
```yaml
k8s_services_cert: |
  ----BEGIN CERTIFICATE----
  - Your certificate here -
  -----END CERTIFICATE-----
k8s_services_cert_key: |
  ----BEGIN PRIVATE KEY----
  - Your private key here -
  -----END PRIVATE KEY-----
```


Example Playbook
----------------

    - hosts:
        - master
      roles:
        - policy

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
