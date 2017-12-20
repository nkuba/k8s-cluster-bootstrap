#!/bin/bash
NODES_NUMBER=$1

mkdir -p $KUBECONFIG_DIR/ && cd $KUBECONFIG_DIR/

# kube-proxy configuration file
echo "Generate kube-proxy configuration file"

kubectl config set-cluster $KUBERNETES_CLUSTER \
  --certificate-authority=$CERTS_GEN_DIR/ca.pem \
  --embed-certs=true \
  --server=https://$KUBERNETES_PUBLIC_ADDRESS:6443 \
  --kubeconfig=$KUBECONFIG_DIR/kube-proxy.kubeconfig

kubectl config set-credentials kube-proxy \
  --client-certificate=$CERTS_GEN_DIR/kube-proxy.pem \
  --client-key=$CERTS_GEN_DIR/kube-proxy-key.pem \
  --embed-certs=true \
  --kubeconfig=$KUBECONFIG_DIR/kube-proxy.kubeconfig

kubectl config set-context default \
  --cluster=$KUBERNETES_CLUSTER \
  --user=kube-proxy \
  --kubeconfig=$KUBECONFIG_DIR/kube-proxy.kubeconfig

kubectl config use-context default --kubeconfig=$KUBECONFIG_DIR/kube-proxy.kubeconfig

# GENERATE NODES CERTS
echo "## GENERATE NODES CERTS"
$SCRIPTS_DIR/generate_node_kubeconfig.sh $NODES_NUMBER
