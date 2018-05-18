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


Log level 0 - debug
```yaml
k8s_log_level: 3
```
Use to increase verbosity on particular files, e.g. k8s_log_spec: token_controller*=5,other_controller*=4
```
k8s_log_spec: ''
```

Users access data
```yaml
k8s_admin_token: 'Admin user token should be here'
k8s_admin_username: admin
k8s_admin_password: 'password'
k8s_release_token: 'Release user token should be here'
k8s_release_username: release
k8s_release_password: 'password'
k8s_guest_token: 'Guest user token should be here'
k8s_guest_username: guest
k8s_guest_password: 'password'
```

It will be used as the Internal dns domain name if DNS is enabled.
Services will be discoverable under
<service-name>.<namespace>.svc.<domainname>.<clustername>, e.g.
myservice.default.svc.k8s.cluster
```yaml
k8s_domain_name: k8s
k8s_cluster_name: cluster
k8s_cluster_domain: '{{ k8s_domain_name }}.{{ k8s_cluster_name }}'
```

Kubernetes master and services host names
```yaml
k8s_master_name: master.your-domain-name
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

ETCD client port, peer port
```yaml
etcd_client_port: 2379
```

URL scheme for kubernetes services
```yaml
k8s_url_scheme: https
```

Kubernetes service API port
```yaml
k8s_api_port: 443
```

Kubernetes internal network for services.
Kubernetes services will get fake IP addresses from this range.
This range must not conflict with anything in your infrastructure. These
addresses do not need to be routable and must just be an unused block of space.
```yaml
k8s_services_network: 10.254.0.0/16
```

IP address of kubernetes service
Usually it's first address in services subnet
```yaml
k8s_cluster_service_ip: 10.254.0.1
```

IP address of Kube DNS
It should be in range of services subnet
```yaml
k8s_cluster_dns: 10.254.0.10
```

Internal overlay network. It will assign IP
addresses from this range to individual pods.
This network must be unused block of space.
```yaml
k8s_cluster_cidr: 10.20.0.0/16
```

Kubernetes hyperkube version
```yaml
k8s_version: 1.7.6
```

Container Network Interface (CNI) bin & config path
```yaml
cni_bin_dir: /opt/cni/bin
cni_conf_dir: /etc/kubernetes/cni/net.d
```

Kubernetes configs path
```yaml
k8s_conf_dir: /etc/kubernetes
k8s_manifests_dir: '{{ k8s_conf_dir }}/manifests'
k8s_policy_dir: '{{ k8s_conf_dir }}/policy'
```

Kubelet data path
```yaml
k8s_kubelet_dir: /var/lib/kubelet
```

Executable files path
```yaml
k8s_bin_dir: /usr/bin
```

Systemd services path
```yaml
k8s_svc_dir: /usr/lib/systemd/system
```

Systemd configs path
```yaml
k8s_svc_conf_dir: /etc/systemd/system.conf.d
```

Master hosts nsmes
```yaml
k8s_master_hosts: {}
```

Nodes hosts names
```yaml
k8s_node_hosts: {}
```


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
