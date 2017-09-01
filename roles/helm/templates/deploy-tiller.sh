#!/bin/bash

function deploy_helm_tiller {
    if kubectl get deploy -l app=helm,name=tiller --namespace=kube-system | grep tiller-deploy &> /dev/null; then
        echo "Helm tiller already exists"
    else
        echo "Creating Helm tiller"
        kubectl apply -f {{ k8s_addons_dir }}/helm-tiller.yaml
    fi

  echo
}

deploy_helm_tiller
