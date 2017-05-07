Ansible Role: Network
=====================

This role install network subnet and firewall on GCE.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

This role require the apache-libcloud module which you can install from pip:

```sh
pip install apache-libcloud
```

Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

A service account's credentials include a generated email address that is unique.
Specify the email address of the user account.
You can create service account according to the [procedure](https://developers.google.com/identity/protocols/OAuth2ServiceAccount#creatinganaccount).
```yaml
gce_service_account_email: "your service account email"
```

Specify your project ID which one used from your GCP account.
```yaml
gce_project_id: "your project id"
```

Specify full path of your unique service account credentials file. 
Details on generating this can be found at [https://docs.ansible.com](https://docs.ansible.com/ansible/guide_gce.html#credentials).
You can download json credentials according to the [procedure](https://support.google.com/cloud/answer/6158849?hl=en&ref_topic=6262490#serviceaccounts)
```yaml
gce_credentials_file: 'gcloud.json'
```

A region is a specific geographical location where you can run your resources.
Each region has one or more zones.
```yaml
gce_instances_region: europe-west1
```

A zone is an isolated location within a region.
Resources that live in a zone, such as instances, are referred to as zonal resources.
```yaml
gce_instances_zone: europe-west1-b
```

GCE instances IP addresses range. It should be an IP addresses range corresponed with zone, e.g.
Western Europe Zone has `10.132.0.0/20` IP range.
Use default IP range for determined zone in most of all cases.
```yaml
gce_instances_ip_range: 10.132.0.0/24
```

Flannel internal overlay network. It will assign IP addresses from this range to individual pods.
This network must be unused block of space.
```yaml
gce_overlay_ip_range: 10.20.0.0/16
```

It will be used as the Internal dns domain name if DNS is enabled.
Services will be discoverable under
`<service-name>.<namespace>.svc.<domainname>.<clustername>`, e.g.
`myservice.default.svc.k8s.cluster`.
```yaml
gce_domain_name: k8s
gce_cluster_name: cluster
```

The network determines what network traffic the instance can access.
Use auto generated network name in most of all cases.
```yaml
gce_network_name: k8s
```

Assigns the instance an IPv4 address from the subnetwork’s range.
Use auto generated subnetwork name in most of all cases.
```yaml
gce_subnet_name: k8s-cluster
```


Example Playbook
----------------

	- hosts: localhost
	  connection: local
	  roles:
	    - network

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
