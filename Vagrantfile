VAGRANTFILE_API_VERSION = "2"
N_NODES = 3

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  ENV["ANSIBLE_ROLES_PATH"] = "ansible/roles"
  config.vm.box = "bento/ubuntu-18.04"

  config.vm.provider :virtualbox do |v|
    v.memory = 1024
  end

  (1..N_NODES).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.hostname = "node-#{i}"
      node.vm.network :private_network, ip: "10.10.10.#{20 + i}"

      if i == N_NODES
        node.vm.provision :ansible, run: :always do |ansible|
          ansible.limit = "all"
          ansible.verbose = "v"
          ansible.compatibility_mode = "2.0"
          ansible.playbook = "ansible/playbooks/site.yml"
          ansible.groups = {
            "seeds" => ["node-1"]
          }
        end
      end
    end
  end
end
