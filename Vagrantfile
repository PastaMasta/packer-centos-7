# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.ssh.insert_key = false
  config.ssh.private_key_path = './id_rsa'
  config.ssh.username = 'vagrant'
  config.vm.synced_folder '.', '/vagrant', disabled: true

  config.vm.define :base do |base|

    base.vm.hostname = "centos-7-candidate"
    base.vm.box = "centos-7-candidate"

    base.vm.network :public_network,
      :dev => "internal",
      :mode => "bridge",
      :type => "bridge"
  end

  config.vm.provider :libvirt do |libvirt|
    libvirt.driver = "kvm"
    libvirt.storage_pool_name = "storage"
  end

end
