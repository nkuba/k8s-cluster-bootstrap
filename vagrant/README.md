# Bootstrapping Virtual Machines with Vagrant
Vagrant will handle Virtual Machines for the cluster. The script uses _Ubuntu Xenial 64-bit_ image.

## Prerequisites
- [ ] [Vagrant](https://www.vagrantup.com/docs/installation/) installed on host machine
- [ ] Generated SSH keys on host machine `ssh-keygen`

## Configuration
In [Vagrantfile](Vagrantfile) set variables:
- _CLUSTER_SIZE_ - number of VMs to create (default _4_)
- _SSH_PRIVATE_KEY_ - path to host SSH private key (default _~/.ssh/id_rsa_)
- _SSH_PUBLIC_KEY_ - path to host SSH public key (default _~/.ssh/id_rsa.pub_)

## Bootstrap Virtual Machines
Each VM  will be configured in following way:
- [hostname](https://www.vagrantup.com/docs/vagrantfile/machine_settings.html#available-settings) set to _node{i}_, e.g. node1
- [private network IP address](https://www.vagrantup.com/docs/networking/private_network.html#static-ip) set to 192.168.10.2{i}, e.g. 192.168.10.21

where {i} is subsequent number of VM from 1 to _CLUSTER_SIZE_

To start VMs execute command:
```bash
vagrant up
```

To start specific VMs provide their names to the command:
```bash
vagrant up node1 node2
```

## Check status of Virtual Machines
To get a status of VMs run:
```bash
vagrant status
```

This command will return similar output:
```
Current machine states:

node1                     running (virtualbox)
node2                     running (virtualbox)
node3                     running (virtualbox)
node4                     running (virtualbox)

This environment represents multiple VMs. The VMs are all listed above with their current state. 
For more information about a specific VM, run `vagrant status NAME`.
```

## SSH to a Virtual Machine
To connect to a running VM via SSH run:
```bash
vagrant ssh node1
```

## Clean Up Virtual Machines
To tear down Virtual Machines run:
```bash
vagrant destroy
```

To destroy specific VMs provide their names to the command:
```bash
vagrant destroy node1 node2
```

## More Vagrant Commands
For more Vagrant commands visit Vagrant Docs [Command-Line Interface](https://www.vagrantup.com/docs/cli/)
