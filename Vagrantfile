# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
vars = YAML.load_file 'vars.yml'

VAGRANT_BOX = vars['shared']['box']
WORKER_NODE_COUNT = vars['shared']['worker_count']
CONTROL_CPU = vars['control']['cpus']
WORKER_CPU = vars['worker']['cpus']
CONTROL_MEM = vars['control']['mem_size']
WORKER_MEM = vars['worker']['mem_size']
NETWORK = vars['shared']['network']

Vagrant.configure("2") do |config|

  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end

  config.vm.synced_folder ".", "/vagrant"
  config.vm.provision "shell", path: "bootstrap.sh"
  config.vm.provision :hosts, :sync_hosts => true

  config.vm.define "controlplane" do |nodes|
    nodes.vm.box = VAGRANT_BOX
    nodes.vm.hostname= "controlplane"
    nodes.vm.network "private_network", ip: NETWORK + "0"
    nodes.vm.provider "virtualbox" do |v|
      v.memory = CONTROL_MEM
      v.cpus = CONTROL_CPU
      v.name = "controlplane"
    end
    config.vm.provision :reload
    nodes.vm.provision "shell", path: "bootstrap_controlplane.sh"
  end

  (1..WORKER_NODE_COUNT).each do |i|
    config.vm.define "worker#{i}" do |nodes|
      nodes.vm.box = VAGRANT_BOX
      nodes.vm.hostname = "worker#{i}"
      nodes.vm.network "private_network", ip: NETWORK + "#{i}"
      nodes.vm.provider "virtualbox" do |v|
        v.memory = WORKER_MEM
        v.cpus = WORKER_CPU
        v.name = "worker#{i}"
      end
      nodes.vm.provision "shell", path: "bootstrap_worker.sh"
    end
  end
end