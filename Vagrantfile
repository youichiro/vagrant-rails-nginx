# -*- mode: ruby -*-

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "private_network", ip: "192.168.33.11"
  config.hostsupdater.aliases = {
      '192.168.33.10' => ['example.com'],
      '192.168.33.11' => ['api.example.com']
  }

  config.vm.provision :shell, :path => "vagrant/init.sh"
end

