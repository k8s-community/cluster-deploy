# cluster-deploy
Kubernetes cluster deployment palybooks

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

## Requirements

All playbooks require the apache-libcloud module which you can install from pip:

```sh
pip install apache-libcloud
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

## Contributors

All the contributors are welcome. If you would like to be the contributor please accept some rules:
- The pull requests will be accepted only in `develop` branch
- All modifications or additions should be tested

Thank you for your understanding!

## License

[MIT Public License](https://github.com/k8s-community/cluster-deploy/blob/master/LICENSE)

## Author Information

Kubernets Community [k8s-community](https://github.com/k8s-community)

