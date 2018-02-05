# Bootstrapping a Kubernetes Cluster from Scratch
This scripts will run a Kubernetes Cluster from scratch.

IN PROGRESS...

## Prerequisites
- [X] [Ansible](http://docs.ansible.com/ansible/latest/intro_installation.html) installed on host machine
- [X] Virtual Machines up and running - use [Vagrant](../vagrant) to run preconfigured VMs


## Run script to set up Kubernetes Cluster
```bash
./setUpCluster.sh
```

## Credits
- [Kubernetes The Hard Way Tutorial](https://github.com/kelseyhightower/kubernetes-the-hard-way) by @kelseyhightower
- Kubernetes Documentation - [Creating a Custom Cluster from Scratch](https://kubernetes.io/docs/getting-started-guides/scratch)


## Run E2E tests

IN PROGRESS...

- [Install golang](https://golang.org/doc/install)

https://github.com/kubernetes/community/blob/master/contributors/devel/e2e-tests.md#testing-against-local-clusters
```bash
export KUBECONFIG=/etc/kubernetes/admin.conf
export KUBE_MASTER_IP="127.0.0.1:6443"
export KUBE_MASTER=local
go run hack/e2e.go -- --provider=local -v --test
```
