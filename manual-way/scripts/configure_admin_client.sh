#!/bin/bash

kubectl config set-cluster $KUBERNETES_CLUSTER \
  --certificate-authority=$CERTS_GEN_DIR/ca.pem \
  --embed-certs=true \
  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443

kubectl config set-credentials admin \
  --client-certificate=$CERTS_GEN_DIR/admin.pem \
  --client-key=$CERTS_GEN_DIR/admin-key.pem

kubectl config set-context $KUBERNETES_CLUSTER \
  --cluster=$KUBERNETES_CLUSTER \
  --user=admin

kubectl config use-context $KUBERNETES_CLUSTER