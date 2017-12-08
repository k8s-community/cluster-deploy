#!/bin/bash

function deploy_default_storage {
    if kubectl get storageclass | grep standard &> /dev/null; then
        echo "Default storage class already exists"
    else
        echo "Creating default storage class"
{% if network_storage and network_storage_type == 'gce' %}
        kubectl create -f {{ k8s_addons_dir }}/gce-storage.yaml
{% endif %}
{% if network_storage and network_storage_type == 'ceph' %}
        kubectl create -f {{ k8s_addons_dir }}/ceph-storage.yaml
{% endif %}
{% if not network_storage %}
        kubectl create -f {{ k8s_addons_dir }}/local-storage.yaml
{% endif %}
    fi
}


function deploy_volumes {
    if kubectl get pv | grep services &> /dev/null; then
        echo "Serices volumes already exists"
    else
        echo "Creating serices volumes"
        kubectl create -f {{ k8s_addons_dir }}/volumes.yaml
    fi

  echo
}

# deploy_default_storage
deploy_volumes
