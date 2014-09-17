Vagrant.configure("2") do |config|
  config.vm.box = "promet_wheezy"
  config.vm.box_url = "https://s3.amazonaws.com/promet_debian_boxes/wheezy_virtualbox.box"
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 2048]
  end

  project = 'default-d7'
  path = "/var/www/sites/#{project}.dev"

  config.vm.synced_folder ".", "/vagrant", :disabled => true
  config.vm.synced_folder ".", path, :nfs => true
  config.vm.hostname = "#{project}.dev"

  config.ssh.forward_agent = true
  config.vm.network :private_network, ip: "10.33.36.11"

  config.vm.provision :shell, inline: "cp #{path}/cnf/sources.list /etc/apt/sources.list"
  config.vm.provision :shell, path: 'build/vagrant.sh', args: path
  config.vm.provision :shell, inline: "su vagrant -c 'cd #{path} && composer install'"
  config.vm.provision :shell, inline: "cd #{path}; [[ -f .env ]] && source .env || source env.dist; build/install.sh"
end
