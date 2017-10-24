#!/bin/bash

function deploy_prometheus {
   if kubectl get deploy -l app=prometheus -n {{ k8s_prometheus_namespace }} | grep prometheus &> /dev/null; then
       echo "Updating Prometheus (config-maps will be auto applied)"
       kubectl apply -f {{ k8s_addons_dir }}/prometheus.yaml
   else
       echo "Creating Prometheus"
       kubectl create -f {{ k8s_addons_dir }}/prometheus.yaml
   fi

   echo
}

deploy_prometheus
