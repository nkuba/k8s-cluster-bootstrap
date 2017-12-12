Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.ssh.insert_key = true
  config.ssh.forward_agent = true

  config.vm.define "node1" do |node|
    node.vm.network "private_network", ip: "192.168.10.21"

    node.vm.hostname = "node1"
    
    node.vm.provision "shell", path: "bootstrap-kubeadm.sh"
  end

  config.vm.define "node2" do |node|
    node.vm.network "private_network", ip: "192.168.10.22"

    node.vm.hostname = "node2"

    node.vm.provision "shell", path: "bootstrap-kubeadm.sh"
  end
  
  config.vm.define "node3" do |node|
    node.vm.network "private_network", ip: "192.168.10.23"

    node.vm.hostname = "node3"

    node.vm.provision "shell", path: "bootstrap-kubeadm.sh"
  end
end
