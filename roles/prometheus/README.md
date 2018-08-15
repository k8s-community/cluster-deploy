Prometheus role
===============

This role installs Prometheus for Kubernetes cluster (endpoints, pods, nodes, istio, ...) with some basic alerts, dashboards and etc.

[Official documentation](https://prometheus.io/docs/introduction/overview/)

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/k8s-community/cluster-deploy/issues)

Requirements
------------

No special requirements.

Role Variables
--------------

You can see all available params  in `defaults/main.yml` with default values and descriptions why it needs. By default, all prometheus components will be created in `prometheus` namespace (even if it doesn't exist before). Node exporter will be ran on all nodes (even on master nodes).

How to create new alert
-----------------------

New alerts can be added in `templates/alerts` directory (check already existing alerts). For example:

    #
    # Alert on deployment has not enough replicas
    #
    - alert: DeploymentReplicasMismatch
      expr: (kube_deployment_spec_replicas != kube_deployment_status_replicas_available)
        or (kube_deployment_spec_replicas unless kube_deployment_status_replicas_unavailable)
      for: 5m
      labels:
        notify: sre
        severity: warning
      annotations:
        summary: "{{ $labels.kubernetes_namespace }}/{{ $labels.deployment }}: Deployment is failed"
        description: "{{ $labels.kubernetes_namespace }}/{{ $labels.deployment }}: Deployment is failed - observed replicas != intended replicas"

It's better to have short description of alert in top for other people. You can use different labels for alerts, we offer to follow recommendations from `templates/alerts/common.conf`.

If you want to create a new file with alerts in `templates/alerts` then you need to add line with file name also in `templates/server.yaml` after creation. Template:

    {% raw %}
        #
        # Some alerts for something
        #
        - name: some-alerts
          rules:

          #
          # Alert on something
          #
          - alert: SomethingWrong
          ....

    {% endraw %}

More details about alerts on: [Official documentation about alerts](https://prometheus.io/docs/alerting/rules/)

What configs should app have
----------------------------

You will have to do some changes in manifests / charts if you want to monitor your apps. Changes are described below.

Ingress should have:

    annotations:
        prometheus.io/probe: 'true'

Black box exporter would check your app via HTTPS check if it needs this check (and SSL certificate expiration).

Service should have:

    annotations:
        prometheus.io/scrape: 'true'
        prometheus.io/probe: 'true'
        # by default (pass this values only if it should be different)
        prometheus.io/port: '8080'
        prometheus.io/path: '/metrics'

Black box exporter would check your app via HTTP check if other apps can communicate with it inside Kubernetes cluster. Also all metrics would be scraped from each pod of your app to create your custom alerts in future. By default, the system monitors only 5XX HTTP codes for apps.

How to create new scrape configs
--------------------------------

New scrape configs can be added in `templates/scrape_configs` directory (check already existing scrapes). If you create a new file then you need to add it also in `templates/server.yaml`. Template:

    {% raw %}
          # A scrape configuration for something.
          #
          - job_name: some-thing
          ...

    {% endraw %}

All details about scrape config on: [Official documentation about scrape configs](https://prometheus.io/docs/operating/configuration/#<scrape_config>)

How to add dashboard in Grafana
-----------------------------------

1. create a new dashboard manually via `Dashboards --> New` or find existing on [grafana.com](https://grafana.com/dashboards)
2. export (download) it on your computer
3. copy content of downloaded JSON file
4. create a new file in `templates/grafana-dashboards` directory. Template (`templates/grafana-dashboards/dashboard-template.json`):

        {% raw %}
        {
          "dashboard": {
            ... <copied content data> ...
          },
          "overwrite": true,
          "inputs": [
            {
              "name": "DS_PROMETHEUS",
              "type": "datasource",
              "pluginId": "prometheus",
              "value": "prometheus"
            }
          ]
        }{% endraw %}

5. add line with file name in `templates/grafana.yaml`.

Example Playbook
----------------

    - hosts: addons
      roles:
        - prometheus

License
-------

MIT

Author Information
------------------

Kubernets Community [k8s-community](https://github.com/k8s-community)