#!/bin/bash

function deploy_dashboard {
    if kubectl get deploy -l k8s-app=kubernetes-dashboard --namespace=kube-system | grep kubernetes-dashboard &> /dev/null; then
        echo "Kubernetes Dashboard deployment already exists"
    else
        echo "Creating Kubernetes Dashboard deployment"
        kubectl apply -f {{ k8s_addons_dir }}/dashboard.yaml
    fi

  echo
}

deploy_dashboard
