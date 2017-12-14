# k8s-training
Kubernetes training

## Bootstrapping a cluster with kubeadm
### Prerequisites
You will need following tools on your host machine:
- [ ] [Vagrant](https://www.vagrantup.com/docs/installation/)
- [ ] [Ansible](http://docs.ansible.com/ansible/latest/intro_installation.html)

### Bootstrap 3 VMs with Vagrant
```bash
cd vagrant/ && vagrant up
```
### Run script to set up hosts with Ansible
```bash
cd ansible/ && ./setUp1m2w.sh
```
