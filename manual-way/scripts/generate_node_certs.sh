#!/bin/bash
NODES_NUMBER=$1

echo "Generate certificates for $NODES_NUMBER nodes"

for i in $(seq 1 $NODES_NUMBER);
do
NODE=node$i

    echo "Generate cert for node: $NODE"
    cat > $CERTS_CONFIG_DIR/$NODE-csr.json <<EOF
{
  "CN": "system:node:$NODE",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:nodes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

    cfssl gencert \
      -ca=$CERTS_GEN_DIR/ca.pem \
      -ca-key=$CERTS_GEN_DIR/ca-key.pem \
      -config=$CERTS_CONFIG_DIR/ca-config.json \
      -hostname=$NODE,192.168.10.2$i \
      -profile=kubernetes \
      $CERTS_CONFIG_DIR/$NODE-csr.json | cfssljson -bare $NODE

#rm $CERTS_CONFIG_DIR/node$i-csr.json
done