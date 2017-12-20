# Bootstrapping a Kubernetes Cluster with kubeadm
This scripts will run a Kubernetes Cluster with use of kubeadm tool.
Three steps will be executed:
- Docker installation on all nodes
- Installation of Kubernetes binaries (_kubelet_, _kubectl_, _kubeadm_)
- Bootstraping of the Cluster with `kubeadm init` and `kubeadm join`

## Prerequisites
- [ ] [Ansible](http://docs.ansible.com/ansible/latest/intro_installation.html) installed on host machine
- [ ] Virtual Machines up and running - use [Vagrant](../vagrant) to run preconfigured VMs

## Configuration
Cluster configuration can be found in (ansible/inventory/hosts) file.

## Run script to set up Kubernetes Cluster with Ansible
```bash
./run.sh
```
