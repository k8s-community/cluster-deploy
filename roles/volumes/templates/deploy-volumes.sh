#!/bin/bash

function deploy_volumes {
    if kubectl get pv | grep services &> /dev/null; then
        echo "Serices volumes already exists"
    else
        echo "Creating serices volumes"
        kubectl apply -f {{ k8s_addons_dir }}/volumes.yaml
    fi

  echo
}

deploy_volumes
