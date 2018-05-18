#!/bin/bash

function deploy_cockroachdb_volumes {

    if kubectl get pv | grep cockroachdb-volume &> /dev/null; then
        echo "Cockroach DB volumes already exists"
    else
        echo "Creating Cockroach DB volumes"
        kubectl create -f {{ k8s_addons_dir }}/cockroachdb-volumes.yaml
    fi

    echo
}

function deploy_cockroachdb {
    local times=300

    if kubectl get statefulset -l app=cockroachdb | grep cockroachdb &> /dev/null; then
        echo "Cockroach DB already exists"
    else
        echo "Creating Cockroach DB"
        kubectl create -f {{ k8s_addons_dir }}/cockroachdb.yaml
{% if k8s_cockroachdb_secure %}
        echo "Wait for CSR"
        for i in $(seq 0 {{ (k8s_node_hosts | count) - 1 }}); do
            for n in $(seq 1 $times); do
                if kubectl get csr | grep default.node.cockroachdb-${i} &> /dev/null; then
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

function deploy_cockroachdb_init_secure {
    local times=300

    if kubectl get job -l app=cockroachdb | grep cluster-init &> /dev/null; then
        echo "Cockroach DB Secure Init already exists"
    else
        echo "Creating Cockroach DB Secure Init"
        kubectl create -f {{ k8s_addons_dir }}/cockroachdb-init.yaml
        echo "Wait for CSR"
        for j in $(seq 1 $times); do
            if kubectl get csr | grep default.client.root &> /dev/null; then
                kubectl certificate approve default.client.root
                break
            fi
            sleep 1
        done
    fi

    echo
}

function deploy_cockroachdb_init {

    if kubectl get job -l app=cockroachdb | grep cluster-init &> /dev/null; then
        echo "Cockroach DB Init already exists"
    else
        echo "Creating Cockroach DB Init"
        kubectl create -f {{ k8s_addons_dir }}/cockroachdb-init.yaml
    fi

    echo
}

function deploy_cockroachdb_client {

    if kubectl get pod -l app=cockroachdb-client | grep cockroachdb-client &> /dev/null; then
        echo "Cockroach DB Client already exists"
    else
        echo "Creating Cockroach DB Client"
        kubectl create -f {{ k8s_addons_dir }}/cockroachdb-client.yaml
    fi

    echo
}

deploy_cockroachdb_volumes
deploy_cockroachdb
{% if k8s_cockroachdb_secure %}
deploy_cockroachdb_init_secure
{% else %}
deploy_cockroachdb_init
{% endif %}
deploy_cockroachdb_client
