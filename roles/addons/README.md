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

Helm package manager version
```yaml
helm_version: 2.3.1
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

A zone is an isolated location within a region.
Resources that live in a zone, such as instances,
are referred to as zonal resources
```yaml
gce_instances_zone: europe-west1-b
```

Using of network storage
If network storage disabled will use local disk for every requested claim 
```yaml
network_storage: false
```

Name of GCE persistent disk
```yaml
gce_storage_name: pd-std
```

Type of GCE storage, options: `slow`, `fast`
```yaml
gce_storage_type: slow
```

Size of GCE persistent disk in Gb
```yaml
gce_storage_size: 100

k8s_kube_registry_volume_size: '{{ gce_storage_size }}Gi'
k8s_kube_registry_local_size: '5Gi'
```

Kubernetes load balancer type, valid values: `gce`, `nginx`
TODO: load balancer `gce`
```yaml
k8s_lb_type: nginx 
```

Kubernetes configs path
```yaml
k8s_conf_dir: /etc/kubernetes
k8s_policy_dir: '{{ k8s_conf_dir }}/policy'
k8s_addons_dir: '{{ k8s_conf_dir }}/addons'
```

Docker registry path in case of hostPath configuration
```yaml
k8s_kube_registry_dir: /var/lib/kube-registry
```

Nginx stats port
```yaml
k8s_nginx_stats_port: 18080
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

Docker registry secrets
```sh
docker run --rm --entrypoint htpasswd registry:2 -Bbn <user> <password> | base64
```
```yaml
k8s_docker_registry_token: 'docker registry token here'
```
creates docker config with auth info

Solution 1:
-----------
(without login to docker registry)
```sh
kubectl create secret docker-registry my-secret --docker-username=user --docker-password='password' \
--docker-email 'docker@docker.com' --docker-server=<docker_registry_host> --dry-run -o yaml
```
grab hash in field `data.dockercfg` from output result of the command above
```sh
echo '<hash from data.dockercfg>' | base64 --decode
```
grab `auth code` from output result of the command above and save it into `k8s_docker_registry_auth_code`
```
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
Save a result of the command below into `k8s_docker_registry_auth_token`
```sh
cat ~/.docker/config.json | base64
```

Solution 2:
-----------
(need real login to docker registry)
```sh
docker login -u=<user> -p=<password> <docker_registry_host:port>
``
Grab `auth code` from `~/.docker/config.json` and save it into `k8s_docker_registry_auth_code`
Save a result of the command below into `k8s_docker_registry_auth_token`
```sh
cat ~/.docker/config.json | base64
```

Docker registry auth code and auth token
```yaml
k8s_docker_registry_auth_code: 'docker registry auth code here'
k8s_docker_registry_auth_token: 'docker registry auth config token'
```

Persistent volume reclaim policy
```yaml
k8s_volume_reclaim_policy: Retain
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
