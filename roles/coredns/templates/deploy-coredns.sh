#!/bin/bash

function deploy_dns {
    if kubectl get deploy -l k8s-app=coredns --namespace=kube-system | grep coredns &> /dev/null; then
        echo "CoreDNS deployment already exists"
    else
        echo "Creating CoreDNS deployment"
        kubectl create -f {{ k8s_addons_dir }}/coredns.yaml
    fi

  echo
}


deploy_dns
