#!/bin/bash

function deploy_admin_cluster_role_binding {
    if kubectl get -l basic.auth/user=admin clusterrolebindings | grep admin &> /dev/null; then
        echo "Admin account already exists"
    else
        echo "Creating admin account"
        kubectl apply -f {{ k8s_policy_dir }}/admin-clusterrolebinding.yaml
    fi

  echo
}

function deploy_reader_cluster_role {
    if kubectl get -l basic.auth/role=cluster-reader clusterrole | grep cluster-reader &> /dev/null; then
        echo "Cluster reader account already exists"
    else
        echo "Creating cluster reader account"
        kubectl apply -f {{ k8s_policy_dir }}/cluster-reader-clusterrole.yaml
        kubectl apply -f {{ k8s_policy_dir }}/cluster-reader-clusterrolebinding.yaml
    fi

  echo
}

function deploy_tls_secrets {
    if kubectl get secrets --namespace=kube-system | grep tls-secret &> /dev/null; then
        echo "tls secret already exists"
    else
        echo "Creating tls secret"
{% if k8s_services_cert | length > 1000 %}
        kubectl apply -f {{ k8s_policy_dir }}/tls_secret.yaml
{% else %}
        echo "
apiVersion: v1
kind: Secret
metadata:
  name: tls-secret
data:
  tls.crt: `base64 --wrap=0 {{ ssl_dir }}/{{ ssl_name }}.pem`
  tls.key: `base64 --wrap=0 {{ ssl_dir }}/{{ ssl_name }}-key.pem`
---
apiVersion: v1
kind: Secret
metadata:
  name: tls-secret
  namespace: kube-system
data:
  tls.crt: `base64 --wrap=0 {{ ssl_dir }}/{{ ssl_name }}.pem`
  tls.key: `base64 --wrap=0 {{ ssl_dir }}/{{ ssl_name }}-key.pem`
" | kubectl apply -f -
{% endif %}
    fi

  echo
}

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

deploy_admin_cluster_role_binding
deploy_reader_cluster_role
deploy_tls_secrets
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
