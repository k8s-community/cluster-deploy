#!/bin/bash

function deploy_romana {
    if kubectl get daemonset -l k8s-app=romana --namespace=kube-system | grep romana-agent &> /dev/null; then
        echo "Romana daemonset already exists"
    else
        echo "Creating romana daemonset"
        kubectl apply -f {{ k8s_cni_dir }}/romana.yaml
    fi

  echo
}

function deploy_canal {
    if kubectl get daemonset -l k8s-app=canal --namespace=kube-system | grep canal &> /dev/null; then
        echo "Canal network policy daemonset already exists"
    else
        echo "Creating canal network policy daemonset"
        kubectl apply -f {{ k8s_cni_dir }}/canal.yaml
    fi

  echo
}

{% if cni_type == 'calico' %}
deploy_canal
{% endif %}
{% if cni_type == 'romana' %}
deploy_romana
{% endif %}
