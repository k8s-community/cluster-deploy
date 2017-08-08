#!/bin/bash

function deploy_canal {
    if kubectl get daemonset -l k8s-app=canal --namespace=kube-system | grep canal &> /dev/null; then
        echo "Canal network policy daemonset already exists"
    else
        echo "Creating canal network policy daemonset"
        kubectl apply -f {{ k8s_canal_dir }}/canal.yaml
    fi

  echo
}

deploy_canal
