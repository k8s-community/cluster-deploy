#!/bin/bash

function deploy_config {
    if kubectl get namespaces | grep {{ k8s_istio_namespace }} &> /dev/null; then
        echo "Istio config already exists"
    else
        echo "Creating Istio config"
        kubectl apply -f {{ k8s_istio_dir }}/config.yaml
    fi

  echo
}

function deploy_accounts {
    if kubectl get deploy -l istio=istio-ca --namespace={{ k8s_istio_namespace }} | grep istio-ca &> /dev/null; then
        echo "Istio accounts already exists"
    else
        echo "Creating Istio accounts"
        kubectl apply -f {{ k8s_istio_dir }}/accounts.yaml
    fi

  echo
}

function deploy_ingress_certs_secrets {
    if kubectl get secrets --namespace={{ k8s_istio_namespace }} | grep istio-ingress-certs &> /dev/null; then
        echo "Ingress certs secret already exists"
    else
        echo "Creating Ingress certs secret"
{% if k8s_services_cert | length > 1000 %}
        kubectl apply -f {{ k8s_istio_dir }}/ingress-certs-secret.yaml
{% else %}
        echo "
---

apiVersion: v1
kind: Secret
metadata:
  name: istio-ingress-certs
  namespace: {{ k8s_istio_namespace }} 
data:
  tls.crt: `base64 --wrap=0 {{ ssl_dir }}/{{ ssl_name }}.pem`
  tls.key: `base64 --wrap=0 {{ ssl_dir }}/{{ ssl_name }}-key.pem`
" | kubectl apply -f -
{% endif %}
    fi

  echo
}

function deploy_zipkin {
    if kubectl get deploy -l app=zipkin --namespace={{ k8s_istio_namespace }} | grep zipkin &> /dev/null; then
        echo "Zipkin already exists"
    else
        echo "Creating zipkin"
        kubectl apply -f {{ k8s_istio_dir }}/zipkin.yaml
    fi

  echo
}

function deploy_grafana {
    if kubectl get deploy -l app=grafana --namespace={{ k8s_istio_namespace }} | grep grafana &> /dev/null; then
        echo "Grafana already exists"
    else
        echo "Creating grafana"
        kubectl apply -f {{ k8s_istio_dir }}/grafana.yaml
    fi

  echo
}

function deploy_servicegraph {
    if kubectl get deploy -l app=servicegraph --namespace={{ k8s_istio_namespace }} | grep servicegraph &> /dev/null; then
        echo "Servicegraph already exists"
    else
        echo "Creating servicegraph"
        kubectl apply -f {{ k8s_istio_dir }}/servicegraph.yaml
    fi

  echo
}

function deploy_prometheus {
    if kubectl get deploy -l app=prometheus --namespace={{ k8s_istio_namespace }} | grep prometheus &> /dev/null; then
        echo "Prometheus already exists"
    else
        echo "Creating prometheus"
        kubectl apply -f {{ k8s_istio_dir }}/prometheus.yaml
    fi

  echo
}

function deploy_istio {
    local times=300

    echo "Wait for istio.default secret"
    for n in $(seq 1 $times); do
    	if kubectl get secret --namespace={{ k8s_istio_namespace }} | grep istio.default &> /dev/null; then
    	    break
    	fi
        sleep 1
    done
    if kubectl get deploy -l istio=pilot --namespace={{ k8s_istio_namespace }} | grep istio-pilot &> /dev/null; then
        echo "Istio already exists"
    else
        echo "Creating Istio"
        kubectl apply -f {{ k8s_istio_dir }}/istio.yaml
    fi

  echo
}

function deploy_initializer {
    if kubectl get deploy -l istio=istio-initializer --namespace={{ k8s_istio_namespace }} | grep istio-initializer &> /dev/null; then
        echo "Istio initializer already exists"
    else
        echo "Creating Istio initializer"
        kubectl apply -f {{ k8s_istio_dir }}/initializer.yaml
    fi

  echo
}

deploy_config
deploy_accounts
deploy_ingress_certs_secrets
deploy_zipkin
deploy_grafana
deploy_servicegraph
deploy_prometheus
deploy_istio
deploy_initializer
