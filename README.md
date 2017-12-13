# k8s-training
Kubernetes training

## Bootstrapping a cluster with kubeadm
Bootstrap 3 VMs
```bash
cd vagrant
vagrant up
```
Run script to set up hosts via Ansible
```bash
cd ../ansible
./setUp1m2w.sh
```