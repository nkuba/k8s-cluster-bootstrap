#!/bin/bash
NODES_NUMBER=$1

echo "Generate config for $NODES_NUMBER nodes"

for i in $(seq 1 $NODES_NUMBER);
do
    echo "Generate config for node: $i"

    kubectl config set-cluster $KUBERNETES_CLUSTER \
    --certificate-authority=$CERTS_GEN_DIR/ca.pem \
    --embed-certs=true \
    --server=https://$KUBERNETES_PUBLIC_ADDRESS:6443 \
    --kubeconfig=$KUBECONFIG_DIR/node$i.kubeconfig

    kubectl config set-credentials system:node:node$i \
    --client-certificate=$CERTS_GEN_DIR/node$i.pem \
    --client-key=$CERTS_GEN_DIR/node$i-key.pem \
    --embed-certs=true \
    --kubeconfig=$KUBECONFIG_DIR/node$i.kubeconfig

    kubectl config set-context default \
    --cluster=$KUBERNETES_CLUSTER \
    --user=system:node:node$i \
    --kubeconfig=$KUBECONFIG_DIR/node$i.kubeconfig

    kubectl config use-context default --kubeconfig=$KUBECONFIG_DIR/node$i.kubeconfig

done