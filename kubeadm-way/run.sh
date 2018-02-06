#!/bin/bash
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_INVENTORY="ansible/inventory/hosts"
export PRIVATE_KEY="~/.ssh/id_rsa"

echo "# Install Docker"
ansible-playbook -i $ANSIBLE_INVENTORY --private-key $PRIVATE_KEY ansible/installDocker.yaml

echo "# Install kubeadm"
ansible-playbook -i $ANSIBLE_INVENTORY --private-key $PRIVATE_KEY ansible/installKubernetes.yaml

echo "# Bootstrap cluster"
ansible-playbook -i $ANSIBLE_INVENTORY --private-key $PRIVATE_KEY ansible/bootstrapCluster.yaml

echo "# Configure local client"
ansible-playbook -i $ANSIBLE_INVENTORY --private-key $PRIVATE_KEY ansible/configureClient.yaml
