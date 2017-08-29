# cluster-deploy
Kubernetes cluster deployment palybooks

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

## Requirements

All playbooks require the apache-libcloud module which you can install from pip:

```sh
pip install apache-libcloud
```

Also you can install `Ansible` from pip if it does not installed
```sh
pip install ansible
```

## Playbooks usage

Before using of the playbooks you should change/enter all required vars in `inventory/group_vars/all.yml`

Prepare GCE components. This is optional action related to GCE infrastructure. It should not be used with `prepare-vps.yml`
```sh
ansible-playbook playbooks/prepare-gce.yml
```

Prepare VPS components. This is optional action depend on your provider infrastructure. It should not be used with `prepare-gce.yml`
```sh
ansible-playbook playbooks/prepare-vps.yml
```

Install Kubernetes cluster base components
```sh
ansible-playbook playbooks/setup-base.yml
```

Install Kubernetes additional components
```sh
ansible-playbook playbooks/setup-addons.yml
```

Install Build machine
```sh
ansible-playbook playbooks/setup-build.yml
```

Install CICD
```sh
ansible-playbook playbooks/setup-cicd.yml
```

Install Gateway (Istio, optional)
```sh
ansible-playbook playbooks/setup-gateway.yml
```

All playbooks may be running separately, e.g. `setup Kubernetes components: dashboard, etc`
```sh
ansible-playbook playbooks/cluster/dashboard.yml
```


## Playbooks credentials

A service account's credentials include a generated email address that is unique.
Specify the email address of the user account.
You can create service account according to the [procedure](https://developers.google.com/identity/protocols/OAuth2ServiceAccount#creatinganaccount).

```yaml
gce_service_account_email: '...-compute@developer.gserviceaccount.com'
```

Specify full path of your unique service account credentials file. 
Details on generating this can be found at [https://docs.ansible.com](https://docs.ansible.com/ansible/guide_gce.html#credentials).
You can download json credentials according to the [procedure](https://support.google.com/cloud/answer/6158849?hl=en&ref_topic=6262490#serviceaccounts).

```yaml
gce_credentials_file: 'gcloud.json'
```

Specify your project ID which one used from your GCP account.

```yaml
gce_project_id: my-project-id
```

## Playbooks initial variables

Available variables are listed below, along with default values (see `inventory/group_vars/all.yml`):

Kubernetes master and services host names, you should change that to real host names.
```yaml
k8s_master_name: master.your-domain-name
k8s_services_name: services.your-domain-name
```

Docker registry host name, you should change that to real host name.
```yaml
k8s_registry_name: registry.your-domain-name
```

Charts server repository. This service provide Helm chart repository server with charts templates.
You can see this one as [example](https://github.com/k8s-community/charts).
```yaml
k8s_charts_repo: github.com/k8s-community/charts
```

Country name which used in `C` attribute of certificates (`NL`,`RU`, etc).
```yaml
ssl_country: country-name
```

City name which used in `L` attribute of certificates.
```yaml
ssl_city: city-name
```

Organization name which used in `O` attribute of certificates.
```yaml
ssl_org: organization-name
```

Organization Unit name which used in `OU` attribute of certificates.
```yaml
ssl_division: organization-unit-name
```

State name which used in `ST` attribute of certificates.
```yaml
ssl_state: state-name
```

List of groups with VM instance names and machine types. Instance groups let you
organize VM instances or use them in a load-balancing backend service.
Nodes contain comma separated list of instance names.
Names must start with a lowercase letter followed by up to 63 lowercase letters,
numbers, or hyphens, and cannot end with a hyphen.
Predefined [machine types](https://cloud.google.com/compute/docs/machine-types) are managed by Google Compute Engine.

```yaml
gce_groups:
  - name: master
    type: n1-standard-1
    nodes:
      - k8s-master-01
      - k8s-master-02
      - k8s-master-03
  - name: node
    type: n1-standard-1
    nodes:
      - k8s-node-01
      - k8s-node-02
      - k8s-node-03
  - name: build
    type: n1-standard-1
    nodes:
      - k8s-build-01
```

## Users and services credentials

Kubernetes cluster access data (admin, release and guest)
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


## SSL certificate and private key for running user services into Kubernetes.

You may leave it untouched, in this case SSL certificates will be self-signed. 
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


## Contributors

All the contributors are welcome. If you would like to be the contributor please accept some rules:
- The pull requests will be accepted only in `develop` branch
- All modifications or additions should be tested

Thank you for your understanding!

## License

[MIT Public License](https://github.com/k8s-community/cluster-deploy/blob/master/LICENSE)

## Author Information

Kubernets Community [k8s-community](https://github.com/k8s-community)

