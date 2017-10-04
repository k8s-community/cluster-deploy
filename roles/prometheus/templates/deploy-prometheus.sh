#!/bin/bash

function deploy_prometheus {
   if kubectl get deploy -l k8s-app=prometheus | grep prometheus &> /dev/null; then
       echo "Prometheus already exists"
   else
       echo "Creating Prometheus"
       kubectl create -f {{ k8s_addons_dir }}/prometheus.yaml
   fi

   echo
}

deploy_prometheus
