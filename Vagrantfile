Vagrant.configure("2") do |config|
  # The path to the Berksfile to use with Vagrant Berkshelf
  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "./Berksfile"
  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  config.vm.box = "squeeze"
  config.vm.box_url = "https://s3.amazonaws.com/wa.milton.aws.bucket01/sqeeze.box"

  config.vm.network :private_network, ip: "10.33.36.11"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 2048]
  end
  
  config.ssh.max_tries = 40
  config.ssh.timeout   = 120
  
  config.omnibus.chef_version = :latest

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.network :forwared_port, guest: 80, host: 8080,
  #   auto_correct: true
  # config.vm.network :forwared_port, guest: 22, host: 2201,
  #   auto_correct: true

  project = 'default-d7'
  
  config.vm.hostname = "promet-#{project}"

  config.vm.synced_folder ".", "/var/drupals/#{project}", :nfs => true

    chef_json = {
      :mysql => {
        :server_root_password => 'rootpass',
        :server_debian_password => 'debpass',
        :server_repl_password => 'replpass',
        :tunable => {
          :max_allowed_packet => '512M'
        }
      },
      :apache => {
        :prefork => {
          :startservers => 5,
          :minspareservers => 5,
          :maxspareservers => 5,
          :serverlimit => 10,
          :maxclients => 10
        }
      },
      :drupal => {
        :sites => {
          "#{project}.dev" => {
            :owner => "vagrant",
            :group => "www-data",
            :root => "/var/drupals/#{project}",
            :doc_root => "www",
            :db => "#{project}DB",
            :db_username => "#{project}DBA",
            :db_password => "#{project}PASS",
            :db_init => true,
          }
        }
      },
      :php => {
        :install_method => 'source',
        :version => '5.4.15',
        :directives => {
          :memory_limit => '512M',
        }
      }
    }

    config.vm.provision :chef_solo do |chef|
    chef.add_recipe "solo-helper"
    chef.add_recipe "drupal::default"
    chef.add_recipe "drupal::node_sites"
    chef.add_recipe "drupal::drush"
    chef.json = chef_json
  end
end
