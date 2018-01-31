#!/bin/bash
INVENTORY="ansible/inventory/hosts"
PRIVATE_KEY="~/.ssh/id_rsa"
export ANSIBLE_HOST_KEY_CHECKING=False

echo "# Install Docker"
ansible-playbook -i $INVENTORY --private-key $PRIVATE_KEY ansible/installDocker.yaml

echo "# Install kubeadm"
ansible-playbook -i $INVENTORY --private-key $PRIVATE_KEY ansible/installKubernetes.yaml

echo "# Bootstrap cluster"
ansible-playbook -i $INVENTORY --private-key $PRIVATE_KEY ansible/bootstrapCluster.yaml

scp ubuntu@192.168.10.21:/home/ubuntu/.kube/config .