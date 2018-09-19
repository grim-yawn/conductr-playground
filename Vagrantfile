Vagrant.configure('2') do |config|
  config.vm.box = 'bento/ubuntu-18.04'
  
  [1, 2, 3].each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.provision :shell, inline: "echo node-#{i}"
    end
  end
end
