#!/bin/bash

function deploy_kube_lego {
    if kubectl get deploy -l app=kube-lego --namespace=kube-lego | grep kube-lego &> /dev/null; then
        echo "Kube Lego already exists"
    else
        echo "Creating Kube Lego"
        kubectl apply -f {{ k8s_addons_dir }}/kube-lego.yaml
    fi

  echo
}

deploy_kube_lego
