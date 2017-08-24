Ansible Role: CICD
==================

This role install CICD on Redhat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):


Charts server repository
```yaml
k8s_charts_repo: github.com/k8s-community/charts
```

CICD integration services
```yaml
k8s_cicd_services:
  - github-integration
  - user-manager
  - k8s-community
```

CICD repository
```yaml
k8s_cicd_repo: github.com/k8s-community/cicd
```

Kubernetes configs path
```yaml
k8s_conf_dir: /etc/kubernetes
k8s_policy_dir: '{{ k8s_conf_dir }}/policy'
```

Go tools path
```yaml
go_dir: /usr/local
```

Go sources/packages path in home directory
```yaml
go_path: 'gocode'
```

k8s.community services exchange token
```yaml
k8s_community_token: 'k8s-community-token'
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
k8s_github_client_id: 'github client id here'
k8s_github_client_secret: 'github client secret here'
k8s_github_state: 'github state here'
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
	  roles:
	    - cicd

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
