#!/bin/bash

function deploy_dns {
    if kubectl get deploy -l k8s-app=kube-dns --namespace=kube-system | grep kube-dns &> /dev/null; then
        echo "KubeDNS deployment already exists"
    else
        echo "Creating KubeDNS deployment"
        kubectl apply -f {{ k8s_addons_dir }}/kubedns.yaml
    fi

  echo
}

function deploy_dns_autoscaler {
    if kubectl get deploy -l k8s-app=kube-dns-autoscaler --namespace=kube-system | grep kube-dns-autoscaler &> /dev/null; then
        echo "KubeDNS Autoscaler deployment already exists"
    else
        echo "Creating KubeDNS Autoscaler deployment"
        kubectl apply -f {{ k8s_addons_dir }}/kubedns-autoscaler.yaml
    fi

  echo
}

deploy_dns
deploy_dns_autoscaler
