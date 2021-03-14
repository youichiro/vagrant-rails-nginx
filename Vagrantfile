# -*- mode: ruby -*-

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  config.vm.hostname = "example.com"
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provision :shell, :path => "vagrant/init.sh"
end

