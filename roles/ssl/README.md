Ansible Role: SSL Certificates
==============================

This role install SSL Certificates on Redhat linux based systems.

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.


Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):


Generate CA certificate only
```yaml
ssl_ca_only: false
```

SSL certificate name.
The file names will use the same name.
```yaml
ssl_name: kubernetes
```

Path to SSL generators `cfssl` and `cfsssljson`.
```yaml
ssl_bin_dir: /usr/bin
```

Path to files with SSL certificates and keys.
```yaml
ssl_dir: /etc/ssl/kubernetes
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

Key encoding algorithm.
```yaml
ssl_key_algo: rsa
```

Size of hash for key encoding algorithm.
```yaml
ssl_key_size: 2048
```

How much hours certificate will used before expiration.
```yaml
ssl_expiry_hours: 43800h
```

Host names used in X509v3 Subject Alternative Name field.
```yaml
ssl_hosts:
  - '{{ inventory_hostname }}'
```

IP addresses used in X509v3 Subject Alternative Name field.
```yaml
ssl_ips:
  - '{{ ansible_default_ipv4.address }}'
```

Additional host names or IP addresses used in X509v3 Subject Alternative Name field.
```yaml
ssl_custom:
  - '127.0.0.1'
```

Special certificates for Kubernetes components (kubelet, kube-proxy, etc). The fields `CN` and `O` used as user and his group.
```yaml
ssl_clients: []
```


Example Playbook
----------------

    - hosts:
        - master
        - node
      roles:
        - ssl

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)
