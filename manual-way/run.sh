#!/bin/bash
# TODO: Modify approach to run Kubernetes tools as containers:
# https://kubernetes.io/docs/getting-started-guides/scratch/#configuring-and-installing-base-software-on-nodes

# TODO: Modify to Python script

export KUBERNETES_PUBLIC_ADDRESS="192.168.10.21"
export KUBERNETES_CLUSTER="ManualCluster"

mkdir -p tmp/certs/
export CERTS_CONFIG_DIR="$(realpath config/)"
export CERTS_GEN_DIR="$(realpath tmp/certs/)"

export SCRIPTS_DIR="$(realpath scripts/)"

mkdir -p tmp/config/
export KUBECONFIG_DIR="$(realpath tmp/config/)"

echo "Configure Ansible"
export ANSIBLE_HOST_KEY_CHECKING=False

ANSIBLE_INVENTORY="$(realpath ansible/inventory/hosts)"
PRIVATE_KEY="~/.ssh/id_rsa"

NODES_NUMBER=4

# INSTALL CFSSL TOOLS
$SCRIPTS_DIR/install_cfssl.sh

# GENERATE CERTIFICATES
$SCRIPTS_DIR/generate_certificates.sh $NODES_NUMBER

# GENERATE CONFIG FILES
$SCRIPTS_DIR/generate_kubeconfig.sh $NODES_NUMBER

# CONFIGURE ENCRYPTION
ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)

cat > $KUBECONFIG_DIR/encryption-config.yaml <<EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF

# INSTALL KUBECTL
$SCRIPTS_DIR/install_kubectl.sh

### COPY CERTS TO NODES
#ansible-playbook -i $ANSIBLE_INVENTORY --private-key $PRIVATE_KEY ansible/copyCerts.yaml

# BOOTSTRAP ETCD
echo "# BOOTSTRAP ETCD"
ansible-playbook -i $ANSIBLE_INVENTORY --private-key $PRIVATE_KEY ansible/bootstrapEtcd.yaml

# CONFIGURE MASTERS
echo "# CONFIGURE MASTERS"
ansible-playbook -i $ANSIBLE_INVENTORY --private-key $PRIVATE_KEY ansible/configureMasters.yaml

# CONFIGURE WORKERS
echo "# CONFIGURE WORKERS"
ansible-playbook -i $ANSIBLE_INVENTORY --private-key $PRIVATE_KEY ansible/configureWorkers.yaml

# CONFIGURE ADMIN CLIENT
echo "# CONFIGURE ADMIN CLIENT"
$SCRIPTS_DIR/configure_admin_client.sh

# CONFIGURE NETWORK ROUTES
# TODO: CHECK THIS AND REMOVE - USE NETWORK OVERLAY
echo "# CONFIGURE NETWORK ROUTES"
ansible-playbook -i $ANSIBLE_INVENTORY --private-key $PRIVATE_KEY ansible/configurePodNetworkRoute.yaml

# CONFIGURE KUBE-DNS
kubectl create -f https://storage.googleapis.com/kubernetes-the-hard-way/kube-dns.yaml