# Bootstrapping a Kubernetes Cluster with kubeadm
This scripts will run a Kubernetes Cluster with use of kubeadm tool.
Three steps will be executed:
1. Docker installation on all nodes
2. Installation of Kubernetes binaries (_kubelet_, _kubectl_, _kubeadm_)
3. Bootstraping of the Cluster with `kubeadm init` and `kubeadm join`

## Prerequisites
- [ ] [Ansible](http://docs.ansible.com/ansible/latest/intro_installation.html) installed on host machine
- [ ] Virtual Machines up and running - use [Vagrant](../vagrant) to run preconfigured VMs

## Configuration
Cluster configuration can be found in [Ansible inventory file](ansible/inventory/hosts).

## Run script to set up Kubernetes Cluster
```bash
./run.sh
```

## Credits
 - [Kubernetes Documentation](https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm)
