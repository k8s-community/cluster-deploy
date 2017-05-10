Ansible Role: ETCD
==================

This role install ETCD registry on Redhat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

SSL base certificate name
SSL folder and file names will use the same name
```yaml
ssl_name: etcd
```

Path to files with SSL certificates and keys
```yaml
ssl_dir: '/etc/ssl/etcd'
```

ETCD client port, peer port
```yaml
etcd_client_port: 2379
etcd_peer_port: 2380
```

ETCD host names
```yaml
etcd_hosts: [ ]
```

Default directories for configs, datastore
```yaml
etcd_conf_dir: '/etc/etcd'
etcd_data_dir: '/var/lib/etcd'
```

Cluster state and token
```yaml
etcd_initial_cluster_state: 'new'
etcd_initial_cluster_token: 'etcd-cluster'
```

URL scheme for clients and between peers
```yaml
etcd_url_scheme: https
etcd_peer_url_scheme: https
```

When this is set etcd will check all incoming HTTPS requests for a
client certificate signed by the trusted CA,
requests that don't supply a valid client certificate will fail.
```yaml
etcd_client_cert_auth: false
```

When set, etcd will check all incoming peer requests from the cluster
for valid client certificates signed by the supplied CA.
```yaml
etcd_peer_client_cert_auth: false
```


Example Playbook
----------------

    - hosts: etcd
      roles:
        - role: etcd
          etcd_hosts: '{{ groups["etcd"] }}'

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
