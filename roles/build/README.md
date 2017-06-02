Ansible Role: Build Machine
===========================

This role install Build Machine on Redhat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

Account name of remote user. Ansible will use this user account to ssh into
the managed machines. The user must be able to use sudo without asking for password
```yaml
k8s_ssh_user: dev
```

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

Docker registry host name
```yaml
k8s_registry_name: registry.your-domain-name
```

Path to files with SSL certificates and keys
```yaml
ssl_dir: /etc/ssl/kubernetes
```

URL scheme for kubernetes services
```yaml
k8s_url_scheme: https
```

Kubernetes service API port
```yaml
k8s_api_port: 443
```

IP address of kubernetes service
Usually it's first address in services subnet
```yaml
k8s_cluster_service_ip: 10.254.0.1
```

Kubernetes hyperkube version
```yaml
k8s_version: 1.5.6
```

Helm package manager version
```yaml
helm_version: 2.3.1
```

Golang compiller version
```yaml
go_version: 1.8.1
```

Kubernetes configs path
```yaml
k8s_conf_dir: /etc/kubernetes
k8s_policy_dir: '{{ k8s_conf_dir }}/policy'
```

Executable files path
```yaml
k8s_bin_dir: /usr/bin
```

Go tools path
```yaml
go_dir: /usr/local
```

Go sources/packages path in home directory
```yaml
go_path: 'gocode'
```

k8s.community services databases credentials
```yaml
k8s_community_db_username: 'k8s-community'
k8s_community_db_password: 'k8s.community'
k8s_github_integration_db_username: 'github-integration'
k8s_github_integration_db_password: 'github.integration'
```

k8s.community Github integration services secrets
```yaml
k8s_github_client_id: 'client id here'
k8s_github_client_secret: 'client secret here'
k8s_github_integration_id: 'github integration id here'
k8s_github_integration_token: 'github integration token here'
k8s_github_integration_private_key: |
  -----BEGIN RSA PRIVATE KEY-----
  - Your RSA private key here -
  -----END RSA PRIVATE KEY-----
```


Example Playbook
----------------

	- hosts: build
	  remote_user: dev
	  become: true
	  become_method: sudo
	  roles:
	    - build

	- hosts: build
	  remote_user: dev
	  roles:
	    - build

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
