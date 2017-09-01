#!/bin/bash

function deploy_nginx_ingress_controller {
    if kubectl get ds -l k8s-app=nginx-ingress-controller --namespace=kube-system | grep nginx-ingress-controller &> /dev/null; then
        echo "Nginx Ingress controller already exists"
    else
        echo "Creating Nginx Ingress controller"
        kubectl apply -f {{ k8s_addons_dir }}/nginx-ingress-controller.yaml
    fi

  echo
}

function deploy_haproxy_ingress_controller {
    if kubectl get deploy -l k8s-app=haproxy-ingress-controller --namespace=kube-system | grep haproxy-ingress-controller &> /dev/null; then
        echo "HAProxy Ingress controller already exists"
    else
        echo "Creating HAProxy Ingress controller"
        kubectl apply -f {{ k8s_addons_dir }}/haproxy-ingress-controller.yaml
    fi

  echo
}

function deploy_gce_ingress_controller {
    if kubectl get deploy -l k8s-app=gce-ingress-controller --namespace=kube-system | grep gce-ingress-controller &> /dev/null; then
        echo "Google L7 Ingress controller already exists"
    else
        echo "Creating Google L7 Ingress controller"
        kubectl apply -f {{ k8s_addons_dir }}/gce-ingress-controller.yaml
    fi

  echo
}


{% if k8s_lb_type == 'nginx' %}
deploy_nginx_ingress_controller
{% endif %}
{% if k8s_lb_type == 'haproxy' %}
deploy_haproxy_ingress_controller
{% endif %}
{% if k8s_lb_type == 'gce' %}
deploy_gce_ingress_controller
{% endif %}
