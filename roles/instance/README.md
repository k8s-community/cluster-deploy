Ansible Role: Instance
======================

This role install VM instance on GCE.

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
You can download json credentials according to the [procedure](https://support.google.com/cloud/answer/6158849?hl=en&ref_topic=6262490#serviceaccounts).
```yaml
gce_credentials_file: 'gcloud.json'
```

It will be used as the Internal dns domain name if DNS is enabled.
Services will be discoverable under
`<service-name>.<namespace>.svc.<domainname>.<clustername>`, e.g.
`myservice.default.svc.k8s.cluster`
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

Forwarding allows the instance to help route packets.
```yaml
gce_ip_forward: true
```

Path to the Inventory hosts file.
It should be auto generated during the crating of VM inctances.
```yaml
gce_inventory_file: '{{ inventory_dir }}/cluster'
```

Account name of remote user. Ansible will use this user account to ssh into the managed machines.
The user must be able to use sudo without asking for password.
```yaml
gce_ssh_user: dev
```

SSH key that will be used to connect your VM instances.
Use this default value if you won't use special separate key for this purposes.
```yaml
gce_ssh_key: '{{ lookup("file", "{{ ansible_env.HOME }}/.ssh/id_rsa.pub") }}'
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

Predefined [machine type](https://cloud.google.com/compute/docs/machine-types) which managed by Google Compute Engine.
```yaml
gce_machine_type: n1-standard-1
```

Instance groups let you organize VM instances or use them in a load-balancing backend service.
```yaml
gce_instance_group: test
```

A comma separated list of instance names. Names must start with a lowercase letter followed by up to 63 lowercase letters, numbers, or hyphens, and cannot end with a hyphen.
```yaml
gce_instance_names: test1,test2
```

Each instance requires a disk to boot from.
Specify an image when you create an instance.
List of predefined [images](https://cloud.google.com/compute/docs/images).
```yaml
gce_image: debian-8
```

You can choose to specify a startup script that will run when your instance boots up or restarts. Startup scripts can be used to install software and updates, and to ensure that services are running within the virtual machine. [Learn more](https://cloud.google.com/compute/docs/startupscript).
```yaml
gce_startup_script: |
  #!/bin/bash

  apt-get update
```

TODO. It is worked only with ansible version started from 2.3.
Specify a boot disk size in Gigabytes. 
```yaml
gce_disk_size: 50
```

Select the type and level of API access to grant the VM.
Default: read-only access to Storage and Service Management,
write access to Stackdriver Logging and Monitoring,
read/write access to Service Control.
```yaml
gce_sa_permissions:
  - compute-rw
  - logging-write
  - monitoring
  - storage-full
```

Additional metadata to specify custom information like predefined users/ssh kyes or startup script.
```yaml
gce_metadata: 
  ssh-keys: "{{ gce_ssh_user }}:{{ gce_ssh_key }}"
  startup-script: '{{ gce_startup_script }}'
```


Example Playbook
----------------

	- hosts: localhost
	  connection: local
      roles:
        - instance

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
