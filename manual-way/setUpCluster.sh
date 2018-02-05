#!/bin/bash
# TODO: Modify approach to run Kubernetes tools as containers https://kubernetes.io/docs/getting-started-guides/scratch/#configuring-and-installing-base-software-on-nodes
# TODO: Modify to Python script
# TODO: Download binaries once and distribute across nodes. Don't download them multiple times

export KUBERNETES_PUBLIC_ADDRESS="192.168.10.21"
export KUBERNETES_CLUSTER="ManualCluster"
export NODES_NUMBER=4

export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_INVENTORY="$(realpath ansible/inventory/hosts)"
export PRIVATE_KEY="~/.ssh/id_rsa"


rm -rf tmp/
mkdir -p tmp/certs/
export CONFIG_DIR="$(realpath config/)"

export CERTS_GEN_DIR="$(realpath tmp/certs/)"
export SCRIPTS_DIR="$(realpath scripts/)"
export KUBECONFIG_DIR="$(realpath tmp/config/)"

# INSTALL CFSSL TOOLS
#$SCRIPTS_DIR/install_cfssl.sh

# GENERATE CERTIFICATES
# https://kubernetes.io/docs/concepts/cluster-administration/certificates/#cfssl
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
#$SCRIPTS_DIR/install_kubectl.sh

# BOOTSTRAP ETCD
echo "# BOOTSTRAP ETCD"
ansible-playbook -i $ANSIBLE_INVENTORY --private-key $PRIVATE_KEY ansible/configureEtcd.yaml

sleep 30

sleep 30

# CONFIGURE MASTERS
# TODO: Follow instruction to replicate masters: https://kubernetes.io/docs/admin/high-availability/building/
echo "# CONFIGURE MASTERS"
ansible-playbook -i $ANSIBLE_INVENTORY --private-key $PRIVATE_KEY ansible/configureMasters.yaml

# CONFIGURE SECURITY
echo "# CONFIGURE MASTERS"
ansible-playbook -i $ANSIBLE_INVENTORY --private-key $PRIVATE_KEY ansible/configureSecurity.yaml

# CONFIGURE NODES
# TODO: Run Master as a Node with appropriate "master" label node-role.kubernetes.io/master="": https://kubernetes.io/docs/getting-started-guides/scratch/
echo "# CONFIGURE NODES"
ansible-playbook -i $ANSIBLE_INVENTORY --private-key $PRIVATE_KEY ansible/configureContainerd.yaml
ansible-playbook -i $ANSIBLE_INVENTORY --private-key $PRIVATE_KEY ansible/configureNodes.yaml

# CONFIGURE ADMIN CLIENT
echo "# CONFIGURE ADMIN CLIENT"
$SCRIPTS_DIR/configure_admin_client.sh

# CONFIGURE NETWORK
# TODO: CHECK THIS AND REMOVE - USE NETWORK OVERLAY
echo "# CONFIGURE NETWORKING"
ansible-playbook -i $ANSIBLE_INVENTORY --private-key $PRIVATE_KEY ansible/configureNetwork.yaml
kubectl apply -f $CONFIG_DIR/kube-flannel-for-vagrant.yaml

sleep 30

# CONFIGURE KUBE-DNS
kubectl create -f https://storage.googleapis.com/kubernetes-the-hard-way/kube-dns.yaml