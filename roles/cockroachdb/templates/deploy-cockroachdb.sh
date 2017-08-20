#!/bin/bash

function deploy_cockroachdb {
    local times=300

    if kubectl get statefulset -l app=cockroachdb | grep cockroachdb > /dev/null 2>&1; then
        echo "Cockroach DB already exists"
    else
        echo "Creating Cockroach DB"
        kubectl apply -f {{ k8s_addons_dir }}/cockroachdb.yaml
{% if k8s_cockroachdb_secure %}
        echo "Wait for CSR"
        for i in $(seq 0 {{ (k8s_node_hosts | count) - 1 }}); do
            for n in $(seq 1 $times); do
                if kubectl get csr | grep default.node.cockroachdb-${i} > /dev/null 2>&1; then
                    kubectl certificate approve default.node.cockroachdb-${i}
                    break
                fi
                sleep 1
            done
        done
{% endif %}
    fi

    echo
}

deploy_cockroachdb
