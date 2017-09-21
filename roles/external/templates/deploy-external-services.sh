#!/bin/bash

function deploy_external_services {
    if kubectl get -n {{ k8s_namespaces[0] }} services | grep {% if external_services | length > 0 %} {{ external_services[0].name }} {% endif %} &> /dev/null; then
        echo "External services already exist"
    else
        echo "Creating external services"
        kubectl apply -f {{ k8s_addons_dir }}/external-services.yaml
    fi

  echo
}


deploy_external_services
