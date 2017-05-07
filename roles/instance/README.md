Ansible Role: Instance
======================

This role install VM instance on GCE.


Requirements
------------

This role require the apache-libcloud module which you can install from pip:

```sh
pip install apache-libcloud
```

Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

	gce_service_account_email: "your service account email"

A service account's credentials include a generated email address that is unique.
Specify the email address of the user account.
You can create one according to the procedure specified in this [reference](https://developers.google.com/identity/protocols/OAuth2ServiceAccount#creatinganaccount)

	gce_project_id: "your project id"

Specify your project ID which one used from your GCP account

	gce_credentials_file: 'gcloud.json'

The full path of your unique service account credentials file. 
Details on generating this can be found at [https://docs.ansible.com](https://docs.ansible.com/ansible/guide_gce.html#credentials)
You can download json credentials according to the procedure specified in this [reference](https://support.google.com/cloud/answer/6158849?hl=en&ref_topic=6262490#serviceaccounts)

	gce_domain_name: k8s
	gce_cluster_name: cluster

It will be used as the Internal dns domain name if DNS is enabled.
Services will be discoverable under
<service-name>.<namespace>.svc.<domainname>.<clustername>, e.g.
myservice.default.svc.k8s.cluster

	gce_network_name: k8s

The network determines what network traffic the instance can access
Use auto generated network name in most of all cases

	gce_subnet_name: k8s-cluster

Assigns the instance an IPv4 address from the subnetwork’s range.
Use auto generated subnetwork name in most of all cases

	gce_ip_forward: true

Forwarding allows the instance to help route packets

	gce_inventory_file: '{{ inventory_dir }}/cluster'

Path to the Inventory hosts file
It should be auto generated during the crating of VM inctances

	gce_ssh_user: dev

Account name of remote user. Ansible will use this user account to ssh into the managed machines.
The user must be able to use sudo without asking for password

	gce_ssh_key: '{{ lookup("file", "{{ ansible_env.HOME }}/.ssh/id_rsa.pub") }}'

SSH key that will be used to connect your VM instances.
Use this default value if you won't use special separate key for this purposes

	gce_instances_region: europe-west1

A region is a specific geographical location where you can run your resources.
Each region has one or more zones.

	gce_instances_zone: europe-west1-b

A zone is an isolated location within a region.
Resources that live in a zone, such as instances, are referred to as zonal resources

	gce_machine_type: n1-standard-1

Predefined [machine type](https://cloud.google.com/compute/docs/machine-types) which managed by Google Compute Engine.

	gce_instance_group: test

Instance groups let you organize VM instances or use them in a load-balancing backend service

	gce_instance_names: test1,test2

A comma separated list of instance names. Names must start with a lowercase letter followed by up to 63 lowercase letters, numbers, or hyphens, and cannot end with a hyphen

	gce_image: debian-8

Each instance requires a disk to boot from.
Specify an image when you create an instance.
List of predefined [images](https://cloud.google.com/compute/docs/images).

	gce_startup_script: |
	  #!/bin/bash

	  apt-get update

You can choose to specify a startup script that will run when your instance boots up or restarts. Startup scripts can be used to install software and updates, and to ensure that services are running within the virtual machine. [Learn more.](https://cloud.google.com/compute/docs/startupscript)

	gce_disk_size: 50

TODO. It is worked only with ansible version started from 2.3.
Specify a boot disk size in Gigabytes. 

	gce_sa_permissions:
	  - compute-rw
	  - logging-write
	  - monitoring
	  - storage-full

Select the type and level of API access to grant the VM.
Default: read-only access to Storage and Service Management,
write access to Stackdriver Logging and Monitoring,
read/write access to Service Control.

	gce_metadata: 
	  ssh-keys: "{{ gce_ssh_user }}:{{ gce_ssh_key }}"
	  startup-script: '{{ gce_startup_script }}'

Additional metadata to specify custom information like predefined users/ssh kyes or startup script


Dependencies
------------

No dependensies.


Example Playbook
----------------

    - hosts: gcloud
      roles:
        - instance

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
