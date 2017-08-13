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

It will be used as the Internal dns domain name if DNS is enabled.
Services will be discoverable under
`<service-name>.<namespace>.svc.<domainname>.<clustername>`, e.g.
`myservice.default.svc.k8s.cluster`
```yaml
k8s_domain_name: k8s
k8s_cluster_name: cluster
k8s_cluster_domain: '{{ k8s_domain_name }}.{{ k8s_cluster_name }}'
```

Kubernetes master and services host names
```yaml
k8s_master_name: master.your-domain-name
k8s_services_name: services.your-domain-name
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

IP address of kubernetes service
Usually it's first address in services subnet
```yaml
k8s_cluster_service_ip: 10.254.0.1
```

Kubernetes configs path
```yaml
k8s_conf_dir: /etc/kubernetes
k8s_policy_dir: '{{ k8s_conf_dir }}/policy'
k8s_addons_dir: '{{ k8s_conf_dir }}/addons'
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

    - hosts: addons
      roles:
        - addons

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
