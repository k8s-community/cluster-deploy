#!/bin/bash

function deploy_kube_registry {
    if kubectl get deploy -l k8s-app=kube-registry --namespace=kube-system | grep kube-registry &> /dev/null; then
        echo "Kube Registry already exists"
    else
        echo "Creating Kube Registry"
        kubectl apply -f {{ k8s_addons_dir }}/kube-registry.yaml
    fi

  echo
}

deploy_kube_registry
