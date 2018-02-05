#!/bin/bash
NODES_NUMBER=$1

mkdir -p $CERTS_GEN_DIR/ && cd $CERTS_GEN_DIR/

## GENERATE CA
echo "## GENERATE CA"
cfssl gencert -initca $CONFIG_DIR/ca-csr.json | cfssljson -bare ca

## GENERATE ADMIN CLIENT CERT
echo "## GENERATE ADMIN CLIENT CERT"
cfssl gencert \
  -profile=kubernetes \
  -ca=$CERTS_GEN_DIR/ca.pem \
  -ca-key=$CERTS_GEN_DIR/ca-key.pem \
  -config=$CONFIG_DIR/ca-config.json \
  $CONFIG_DIR/admin-csr.json | cfssljson -bare admin

# GENERATE NODES CERTS
echo "## GENERATE NODES CERTS"
$SCRIPTS_DIR/generate_node_certs.sh $NODES_NUMBER

# GENERATE KUBE-PROXY CERT
echo "## GENERATE KUBE-PROXY CERT"
cfssl gencert \
  -profile=kubernetes \
  -ca=$CERTS_GEN_DIR/ca.pem \
  -ca-key=$CERTS_GEN_DIR/ca-key.pem \
  -config=$CONFIG_DIR/ca-config.json \
  $CONFIG_DIR/kube-proxy-csr.json | cfssljson -bare kube-proxy

echo "## GENERATE API SERVER CERT"
cfssl gencert \
  -profile=kubernetes \
  -ca=$CERTS_GEN_DIR/ca.pem \
  -ca-key=$CERTS_GEN_DIR/ca-key.pem \
  -config=$CONFIG_DIR/ca-config.json \
  -hostname=10.32.0.1,10.240.0.21,10.240.0.22,$KUBERNETES_PUBLIC_ADDRESS,127.0.0.1,kubernetes.default \
  $CONFIG_DIR/kubernetes-csr.json | cfssljson -bare kubernetes

