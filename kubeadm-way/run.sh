#!/bin/bash
INVENTORY="ansible/inventory/hosts"
PRIVATE_KEY="~/.ssh/id_rsa"

echo "# Configure Ansible"
export ANSIBLE_HOST_KEY_CHECKING=False

echo "# Install Docker"
ansible-playbook -i $INVENTORY --private-key $PRIVATE_KEY ansible/installDocker.yaml

echo "# Install kubeadm"
ansible-playbook -i $INVENTORY --private-key $PRIVATE_KEY ansible/installKubernetes.yaml

echo "# Bootstrap cluster"
ansible-playbook -i $INVENTORY --private-key $PRIVATE_KEY ansible/bootstrapCluster.yaml