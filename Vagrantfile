Vagrant.configure("2") do |config|

  config.vm.box = "raring64"
  config.vm.synced_folder "salt/roots/", "/srv/"
  config.vbguest.auto_update = false

  config.vm.provision :salt do |salt|
    salt.minion_config = "salt/minion"
    salt.run_highstate = true
    salt.verbose = true
  end
end