Vagrant.configure("2") do |config|
  config.vm.box = "promet_wheezy"
  config.vm.box_url = "https://s3.amazonaws.com/promet_debian_boxes/wheezy_virtualbox.box"
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 2048]
  end

  project = 'default-d7'

  config.vm.synced_folder ".", "/vagrant", :disabled => true
  config.vm.synced_folder ".", "/var/www/sites/#{project}.dev", :nfs => true
  config.vm.hostname = "#{project}.dev"

  config.ssh.forward_agent  = true
  config.vm.network :private_network, ip: "10.33.36.11"
end
