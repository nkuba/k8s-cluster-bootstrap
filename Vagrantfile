Vagrant.configure("2") do |config|
  config.vm.define "node1" do |node|
    node.vm.box = "debian/jessie64"

#        web.vm.network :forwarded_port, guest: 8080, host: 28080
    node.vm.network "private_network", ip: "192.168.10.21"
    node.ssh.insert_key = false

    node.vm.provision "shell", path: "bootstrap-kubeadm.sh"
  end

  config.vm.define "node2" do |node|
    node.vm.box = "debian/jessie64"

    node.vm.network "private_network", ip: "192.168.10.22"

    node.vm.provision "shell", path: "bootstrap-kubeadm.sh"
  end
  
  config.vm.define "node3" do |node|
    node.vm.box = "debian/jessie64"

    node.vm.network "private_network", ip: "192.168.10.23"

    node.vm.provision "shell", path: "bootstrap-kubeadm.sh"
  end

end
