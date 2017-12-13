#!/bin/bash

INVENTORY="inventory/hosts1m2w"
PRIVATE_KEY="~/.ssh/id_rsa"

echo "Configure Ansible"
export ANSIBLE_HOST_KEY_CHECKING=False

echo "Install Docker"
ansible-playbook -i $INVENTORY --private-key $PRIVATE_KEY installDocker.yaml

echo "Install kubeadm"
ansible-playbook -i $INVENTORY --private-key $PRIVATE_KEY installKubeadm.yaml

echo "Bootstrap cluster"
ansible-playbook -i $INVENTORY --private-key $PRIVATE_KEY bootstrapCluster.yaml