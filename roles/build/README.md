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


Kubernetes hyperkube version
```yaml
k8s_version: 1.7.6
```

Helm package manager version
```yaml
helm_version: 2.6.1
```

Golang compiller version
```yaml
go_version: 1.9
```

Account name of remote user. Ansible will use this user account to ssh into
the build machines. The user must be able to use sudo without asking
for password for build components
```yaml
k8s_build_ssh_user: dev
```

Docker registry host name
```yaml
k8s_registry_name: registry.your-domain-name
```

Docker registry auth code
```yaml
k8s_docker_registry_auth_code: 'docker-registry-auth-code'
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


Example Playbook
----------------

	- hosts: build
	  roles:
	    - build

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
