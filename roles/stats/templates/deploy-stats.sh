#!/bin/bash

function deploy_heapster {
    if kubectl get deploy -l k8s-app=heapster --namespace=kube-system | grep heapster &> /dev/null; then
        echo "Heapster deployment already exists"
    else
        echo "Creating Heapster deployment"
        kubectl apply -f {{ k8s_addons_dir }}/heapster.yaml
    fi

  echo
}

deploy_heapster
