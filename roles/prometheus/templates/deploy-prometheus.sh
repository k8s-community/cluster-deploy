#!/bin/bash

function deploy_prometheus_config {
   if kubectl get namespaces | grep {{ k8s_prometheus_namespace }} &> /dev/null; then
       echo "Prometheus config already exists"
   else
       echo "Creating Prometheus config"
       kubectl apply -f {{ k8s_prometheus_dir }}/config.yaml
   fi

   echo
}

function deploy_prometheus {
   if kubectl get deploy -l app=prometheus -n {{ k8s_prometheus_namespace }} | grep prometheus &> /dev/null; then
       echo "Updating Prometheus (config-maps will be auto applied)"
       kubectl apply -f {{ k8s_prometheus_dir }}/prometheus.yaml
   else
       echo "Creating Prometheus"
       kubectl create -f {{ k8s_prometheus_dir }}/prometheus.yaml
   fi

   echo
}

deploy_prometheus_config
deploy_prometheus
