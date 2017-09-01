#!/bin/bash

function deploy_accounts {
    if kubectl get deploy -l istio=istio-ca --namespace={{ k8s_istio_namespace }} | grep istio-ca &> /dev/null; then
        echo "Istio accounts already exists"
    else
        echo "Creating Istio accounts"
        kubectl apply -f {{ k8s_addons_dir }}/accounts.yaml
    fi

  echo
}

function deploy_zipkin {
    if kubectl get deploy -l app=zipkin --namespace={{ k8s_istio_namespace }} | grep zipkin &> /dev/null; then
        echo "Zipkin already exists"
    else
        echo "Creating zipkin"
        kubectl apply -f {{ k8s_addons_dir }}/zipkin.yaml
    fi

  echo
}

function deploy_grafana {
    if kubectl get deploy -l app=grafana --namespace={{ k8s_istio_namespace }} | grep grafana &> /dev/null; then
        echo "Grafana already exists"
    else
        echo "Creating grafana"
        kubectl apply -f {{ k8s_addons_dir }}/grafana.yaml
    fi

  echo
}

function deploy_servicegraph {
    if kubectl get deploy -l app=servicegraph --namespace={{ k8s_istio_namespace }} | grep servicegraph &> /dev/null; then
        echo "Servicegraph already exists"
    else
        echo "Creating servicegraph"
        kubectl apply -f {{ k8s_addons_dir }}/servicegraph.yaml
    fi

  echo
}

function deploy_prometheus {
    if kubectl get deploy -l app=prometheus --namespace={{ k8s_istio_namespace }} | grep prometheus &> /dev/null; then
        echo "Prometheus already exists"
    else
        echo "Creating prometheus"
        kubectl apply -f {{ k8s_addons_dir }}/prometheus.yaml
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
        kubectl apply -f {{ k8s_addons_dir }}/istio.yaml
    fi

  echo
}

deploy_accounts
deploy_zipkin
deploy_grafana
deploy_servicegraph
deploy_prometheus
deploy_istio
