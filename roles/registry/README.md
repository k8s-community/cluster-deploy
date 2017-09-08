Ansible Role: Kube registry
===========================

This role install Kube registry on Red Hat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):


Using of network storage
If network storage disabled will use local disk for every requested claim 
```yaml
network_storage: false
```

Kubernetes network persistent disk type, valid values: `gce`
TODO: AWS persistent disk `aws`
```yaml
network_storage_type: gce 
```

Size of network persistent disk in Gb
```yaml
network_storage_size: 100
```

Additional Kubernetes namespaces
```yaml
k8s_namespaces:
  - dev
```

Kube registry host name
```yaml
k8s_registry_name: registry.your-domain-name
```

Network and local persistent disk size
```yaml
k8s_kube_registry_network_volume_size: '{{ network_storage_size / 2 }}Gi'
k8s_kube_registry_local_volume_size: '5Gi'
```

A zone is an isolated location within a region.
Resources that live in a zone, such as instances,
are referred to as zonal resources
```yaml
gce_instances_zone: europe-west1-b
```

Name of GCE persistent disk
```yaml
gce_storage_name: pd-std
```

Type of GCE storage, options: `slow`, `fast`
```yaml
gce_storage_type: slow
```

Ceph monitor port
```yaml
ceph_monitor_port: 6789

Ceph pool name
```yaml
ceph_pull_name: rbd
```

Ceph RBD image name
```yaml
ceph_rbd_image_name: rbdstore
```

Ceph user name
```yaml
ceph_user_name: 'ceph user name'
```

Ceph user token
ceph auth print-key client.admin | base64
```yaml
ceph_user_token: 'ceph user token here'
```

Kubernetes configs path
```yaml
k8s_conf_dir: /etc/kubernetes
k8s_addons_dir: '{{ k8s_conf_dir }}/addons'
```

Master hosts nsmes
```yaml
k8s_master_hosts: {}
```

Storage hosts names
```yaml
k8s_storage_hosts: {}
```


## Docker registry secrets

To get it we should do some strange things, but it needs anyway.
First of all, we should prepare access token for `Docker Registry`
```sh
docker run --rm --entrypoint htpasswd registry:2 -Bbn <user> <password> | base64
```
```yaml
k8s_docker_registry_token: 'docker registry token here'
```
Second, we should create docker config with auth code, auth token and there are two ways:

### Solution 1:
(without login to docker registry)
```sh
kubectl create secret docker-registry my-secret --docker-username=user --docker-password='password' \
--docker-email 'docker@docker.com' --docker-server=<docker_registry_host> --dry-run -o yaml
```
grab hash in field `data.dockercfg` from output result of the command above
```sh
echo '<hash from data.dockercfg>' | base64 --decode
```
grab `auth code` from output result of the command above

create `.docker/config.json`
```json
{
  "auths": {
    "<docker_registry_host>": {
      "auth": "<auth_code_from_previous_command>"
    }
  }
}
```

### Solution 2:
(need real login to docker registry)
```sh
docker login -u=<user> -p=<password> <docker_registry_host:port>
```

### Where to put the results?

Enter auth code from `.docker/config.json` here
```yaml
k8s_docker_registry_auth_code: 'docker registry auth code here'
```

Enter result of `cat .docker/config.json | base64` here
```yaml
k8s_docker_registry_auth_token: 'docker registry auth config token'
```

Example Playbook
----------------

    - hosts: addons
      roles:
        - registry

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
