#!/usr/bin/env bash

echo "--------------- Installing prerequisites"
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

echo "--------------- Adding Docker repo"
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "--------------- Adding Kubernetes repo"
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

echo "--------------- Updating repo"
sudo apt-get update

echo "--------------- Installing Docker"
sudo apt-get install -y docker-ce=17.03.2~ce-0~ubuntu-xenial

echo "-------- Changing user permissions"
sudo usermod -a -G docker $USER

echo "--------------- Installing kubeadm, kubelet and kubectl"
sudo apt-get install -y kubelet kubeadm kubectl

