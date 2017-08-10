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

function deploy_dashboard {
    if kubectl get deploy -l k8s-app=kubernetes-dashboard --namespace=kube-system | grep kubernetes-dashboard &> /dev/null; then
        echo "Kubernetes Dashboard deployment already exists"
    else
        echo "Creating Kubernetes Dashboard deployment"
        kubectl apply -f {{ k8s_addons_dir }}/dashboard.yaml
    fi

  echo
}

function deploy_heapster {
    if kubectl get deploy -l k8s-app=heapster --namespace=kube-system | grep heapster &> /dev/null; then
        echo "Heapster deployment already exists"
    else
        echo "Creating Heapster deployment"
        kubectl apply -f {{ k8s_addons_dir }}/heapster.yaml
    fi

  echo
}

function deploy_nginx_ingress_controller {
    if kubectl get ds -l k8s-app=nginx-ingress-controller --namespace=kube-system | grep nginx-ingress-controller &> /dev/null; then
        echo "Nginx Ingress controller already exists"
    else
        echo "Creating Nginx Ingress controller"
        kubectl apply -f {{ k8s_addons_dir }}/nginx-ingress-controller.yaml
    fi

  echo
}


function deploy_l7_ingress_controller {
    if kubectl get deploy -l k8s-app=glbc --namespace=kube-system | grep l7-ingress-controller &> /dev/null; then
        echo "L7 Ingress controller already exists"
    else
        echo "Creating L7 Ingress controller"
        kubectl apply -f {{ k8s_addons_dir }}/l7-ingress-controller.yaml
    fi

  echo
}

function deploy_kube_registry {
    if kubectl get deploy -l k8s-app=kube-registry --namespace=kube-system | grep kube-registry &> /dev/null; then
        echo "Kube Registry already exists"
    else
        echo "Creating Kube Registry"
        kubectl apply -f {{ k8s_addons_dir }}/kube-registry.yaml
    fi

  echo
}

function deploy_helm_tiller {
    if kubectl get deploy -l app=helm,name=tiller --namespace=kube-system | grep tiller-deploy &> /dev/null; then
        echo "Helm tiller already exists"
    else
        echo "Creating Helm tiller"
        kubectl apply -f {{ k8s_addons_dir }}/helm-tiller.yaml
    fi

  echo
}

function deploy_cockroachdb {
    if kubectl get statefulset -l app=cockroachdb | grep cockroachdb &> /dev/null; then
        echo "Cockroach DB already exists"
    else
        echo "Creating Cockroach DB"
        kubectl apply -f {{ k8s_addons_dir }}/cockroachdb.yaml
    fi

  echo
}

deploy_dns
deploy_dns_autoscaler
deploy_dashboard
deploy_heapster
{% if k8s_lb_type == 'nginx' %}
deploy_nginx_ingress_controller
{% else %}
deploy_l7_ingress_controller
{% endif %}
deploy_kube_registry
deploy_helm_tiller
deploy_cockroachdb
