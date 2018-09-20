VAGRANTFILE_API_VERSION = "2"
N_NODES = 3

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    ENV["ANSIBLE_ROLES_PATH"] = "ansible/roles"

  config.vm.provider :virtualbox do |v|
    v.memory = 1024
  end

  (1..N_NODES).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.box = "bento/ubuntu-18.04"

      node.vm.hostname = "node-#{i}"

      node.vm.network :private_network, ip: "10.10.10.#{20 + i}"

      node.vm.provision :ansible, run: :always do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "ansible/playbooks/site.yml"
        ansible.extra_vars = {
          # Conductr core vars
          conductr_listen_ip: "10.10.10.#{20 + i}",
          conductr_seed: (i != 1) ? "10.10.10.21": "",

          # Conductr agent vars
          conductr_agent_listen_ip: "10.10.10.#{20 + i}",
          conductr_agent_core_ip: "10.10.10.#{20 + i}",
        }
      end

    end

  end

end
