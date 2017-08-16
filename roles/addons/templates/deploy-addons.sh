#!/bin/bash

function deploy_cockroachdb {
    if kubectl get statefulset -l app=cockroachdb | grep cockroachdb > /dev/null 2>&1; then
        echo "Cockroach DB already exists"
    else
        echo "Creating Cockroach DB"
        kubectl apply -f {{ k8s_addons_dir }}/cockroachdb.yaml
    fi

  echo
}

deploy_cockroachdb
