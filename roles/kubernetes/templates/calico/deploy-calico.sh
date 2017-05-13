#!/bin/bash

function deploy_calico_secrets {
    if kubectl get secrets --namespace=kube-system | grep calico-etcd-secrets &> /dev/null; then
        echo "calico etcd secrets already exists"
    else
        echo "Creating calico etcd secrets"
        echo "
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: calico-etcd-secrets
  namespace: kube-system
data:
  etcd-key: `base64 --wrap=0 {{ ssl_dir }}/{{ ssl_name }}-key.pem`
  etcd-cert: `base64 --wrap=0 {{ ssl_dir }}/{{ ssl_name }}.pem`
  etcd-ca: `base64 --wrap=0 {{ ssl_dir }}/ca.pem`
" | kubectl apply -f -
    fi

  echo
}

function deploy_calico {
    if kubectl get deploy -l k8s-app=calico-policy --namespace=kube-system | grep calico-policy &> /dev/null; then
        echo "Calico network policy deployment already exists"
    else
        echo "Creating calico network policy deployment"
        kubectl apply -f {{ k8s_calico_dir }}/calico.yaml
    fi

  echo
}

deploy_calico_secrets
deploy_calico
