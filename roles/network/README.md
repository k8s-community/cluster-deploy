Ansible Role: Network
=====================

This role install network subnet and firewall on GCE.


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

	gce_instances_region: europe-west1

A region is a specific geographical location where you can run your resources.
Each region has one or more zones.

	gce_instances_zone: europe-west1-b

A zone is an isolated location within a region.
Resources that live in a zone, such as instances, are referred to as zonal resources

	gce_instances_ip_range: 10.132.0.0/24

GCE instances IP addresses range. It should be an IP addresses range corresponed with zone, e.g.
Western Europe Zone has 10.132.0.0/20 IP range
Use default IP range for determined zone in most of all cases

	gce_overlay_ip_range: 10.20.0.0/16

Flannel internal overlay network. It will assign IP addresses from this range to individual pods.
This network must be unused block of space.

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

Dependencies
------------

No dependensies.


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
