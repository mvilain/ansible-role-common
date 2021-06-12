#  -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Vagrantfile for ansible-common-role

Vagrant.configure("2") do |config|
  # config.vm.network 'forwarded_port', guest: 80, host: 8080
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.ssh.insert_key = false
#   config.ssh.username = 'root'
  config.ssh.password = 'vagrant'
  config.vm.boot_timeout = 120
  config.vm.provider :virtualbox do |vb|
    #vb.gui = true
    vb.memory = '1024'
  end
  #
  # provision on all machines to allow ssh w/o checking
  #
  config.vm.provision "shell", inline: <<-SHELLALL
    echo "...disabling CheckHostIP..."
    sed -i.orig -e "s/#   CheckHostIP yes/CheckHostIP no/" /etc/ssh/ssh_config
    sed -i -e "s/.*PermitRootLogin.*/PermitRootLogin yes/" /etc/ssh/ssh_config
#     for i in /etc/sysconfig/network-scripts/ifcfg-eth1 /etc/sysconfig/network-scripts/ifcfg-enp0s8; do
#       if [ -e ${i} ]; then echo "...displaying ${i}..."; cat ${i}; fi
#     done
  SHELLALL

# 6/12/21 centos/8 and almalinux/8 stopped being able to auth w/ insecure private key
# https://stackoverflow.com/questions/22922891/vagrant-ssh-authentication-failure
# cp ~/.vagrant.d/insecure_private_key ~/.vagrant/machines/default/virtualbox/private_key
# once box is running, can login with vagrant/vagrant but vagrant can't ssh into it
  config.vm.define "a8" do |a8|
    a8.vm.box = "almalinux/8"
    a8.ssh.insert_key = false
    a8.vm.network 'private_network', ip: '192.168.10.188'
    a8.vm.hostname = 'a8'
    a8.vm.provision "shell", inline: <<-SHELL
      dnf install -y epel-release
      dnf config-manager --set-enabled powertools
      dnf makecache
      dnf install -y ansible
      alternatives --set python /usr/bin/python3
    SHELL
    a8.vm.provision "ansible" do |ansible|
      ansible.compatibility_mode = "2.0"
      ansible.playbook = "site.yaml"
      ansible.inventory_path = "./inventory"
      # ansible.verbose = "v"
      # ansible.raw_arguments = [""]
    end
  end


  config.vm.define "c6" do |c6|
      c6.vm.box = "bento/centos-6"
      c6.ssh.insert_key = false
      c6.vm.network 'private_network', ip: '192.168.10.106'
      c6.vm.hostname = 'c6'
      c6.vm.provision "shell", inline: <<-SHELL
        yum install -y python libselinux-python
      SHELL
      c6.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
        # ansible.verbose = "v"
        # ansible.raw_arguments = [""]
      end
  end

  config.vm.define "c7" do |c7|
      c7.vm.box = "centos/7"
      c7.ssh.insert_key = false
      c7.vm.network 'private_network', ip: '192.168.10.107'
      c7.vm.hostname = 'c7'
      c7.vm.provision "shell", inline: <<-SHELL
        yum install -y python libselinux-python
      SHELL
      c7.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
  end
  
  # 6/12/21 centos/8 and almalinux/8 stopped being able to auth w/ insecure private key
  # so switch to bento's release
  # https://bugzilla.redhat.com/show_bug.cgi?id=1820925
  config.vm.define "c8" do |c8|
      c8.vm.box = "bento/centos-8"
      c8.ssh.insert_key = false
      c8.vm.network 'private_network', ip: '192.168.10.108'
      c8.vm.hostname = 'c8'
    c8.vm.provision "shell", inline: <<-SHELL
      dnf install -y epel-release
      dnf config-manager --set-enabled powertools
      dnf makecache
      dnf install -y ansible
      alternatives --set python /usr/bin/python3
    SHELL
    c8.vm.provision "ansible" do |ansible|
      ansible.compatibility_mode = "2.0"
      ansible.playbook = "site.yaml"
      ansible.inventory_path = "./inventory"
    end
  end

    # https://stackoverflow.com/questions/56460494/apt-get-install-apt-transport-https-fails-in-docker
  config.vm.define "d9" do |d9|
      d9.vm.box = "debian/stretch64"
      d9.ssh.insert_key = false
      d9.vm.network 'private_network', ip: '192.168.10.209'
      d9.vm.hostname = 'd9'
      d9.vm.provision "shell", inline: <<-SHELL
        apt-get update
        apt-get install -y apt-transport-https
      SHELL
      d9.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
    end

    # don't use apt: update_cache=yes here because it won't work to trap
    # repo change errors like with Debian 10 because of apt-secure server
  config.vm.define "d10" do |d10|
      d10.vm.box = "debian/buster64"
      d10.ssh.insert_key = false
      d10.vm.network 'private_network', ip: '192.168.10.210'
      d10.vm.hostname = 'd10'
      d10.vm.provision "shell", inline: <<-SHELL
        apt-get update --allow-releaseinfo-change -y
        apt-get install -y apt-transport-https
      SHELL
      d10.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
    end


  # fedora-21 vagrant box doesn't set 2nd network config correctly
  # fedora 21 doesn't install sudo
  config.vm.define "f21" do |f21|
      f21.vm.box = "bento/fedora-21"
      f21.ssh.insert_key = false
      f21.vm.network 'private_network', ip: '192.168.10.121'
      f21.vm.hostname = 'f21'
      f21.vm.provision "shell", inline: <<-SHELL
        echo "...installing python (this may take a while)..."
        yum install -y sudo python libselinux-python python3
        echo "...fixing enp0s8..."
        sed -i -e "s/BOOTPROTO=none/BOOTPROTO=static/" /etc/sysconfig/network-scripts/ifcfg-enp0s8
        echo "...restarting network..."
        systemctl restart network
        sleep 10
        systemctl restart network
        ip addr
      SHELL
      f21.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
    end

  # these two versions are tested because 21 still used yum while 22 used dnf
  # https://github.com/rpm-software-management/dnf/commit/176a81e357b8e169008c831963c3b487b3bac40a
  # https://bugzilla.redhat.com/show_bug.cgi?id=1338564
  config.vm.define "f22" do |f22|
      f22.vm.box = "bento/fedora-22"
      f22.ssh.insert_key = false
      f22.vm.network 'private_network', ip: '192.168.10.122'
      f22.vm.hostname = 'f22'
      f22.vm.provision "shell", inline: <<-SHELL
        dnf install -y python libselinux-python python3
      SHELL
      f22.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
  end

  # virtualbox runs the older 5.0 on Fedora 23 and below so test that it works
  # python3 is 3.4 which won't run ansible, so use python2.7 with broken dnf module
  config.vm.define "f23" do |f23|
      f23.vm.box = "bento/fedora-23"
      f23.ssh.insert_key = false
      f23.vm.network 'private_network', ip: '192.168.10.123'
      f23.vm.hostname = 'f23'
      f23.vm.provision "shell", inline: <<-SHELL
        dnf install -y python libselinux-python python3
      SHELL
      f23.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
    end
  
    # virtualbox runs the older 5.0 on Fedora 23 and below so test that it works
    config.vm.define "f24" do |f24|
      f24.vm.box = "bento/fedora-24"
      f24.ssh.insert_key = false
      f24.vm.network 'private_network', ip: '192.168.10.124'
      f24.vm.hostname = 'f24'
      f24.vm.provision "shell", inline: <<-SHELL
        dnf install -y python3
      SHELL
      f24.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
  end

  # virtualbox runs the older 5.0 on Fedora 23 and below so test that it works
  config.vm.define "f25" do |f25|
      f25.vm.box = "bento/fedora-25"
      f25.ssh.insert_key = false
      f25.vm.network 'private_network', ip: '192.168.10.125'
      f25.vm.hostname = 'f25'
      f25.vm.provision "shell", inline: <<-SHELL
        dnf install -y python3
      SHELL
      f25.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
    end

  # virtualbox runs the older 5.0 on Fedora 23 and below so test that it works
  config.vm.define "f26" do |f26|
      f26.vm.box = "bento/fedora-26"
      f26.ssh.insert_key = false
      f26.vm.network 'private_network', ip: '192.168.10.126'
      f26.vm.hostname = 'f26'
      f26.vm.provision "shell", inline: <<-SHELL
        dnf install -y python3
      SHELL
      f26.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
    end

    # virtualbox runs the older 5.0 on Fedora 23 and below so test that it works
    config.vm.define "f27" do |f27|
      f27.vm.box = "bento/fedora-27"
      f27.ssh.insert_key = false
      f27.vm.network 'private_network', ip: '192.168.10.127'
      f27.vm.hostname = 'f27'
      f27.vm.provision "shell", inline: <<-SHELL
        dnf install -y python3
      SHELL
      f27.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
    end

  # virtualbox runs the older 5.0 on Fedora 23 and below so test that it works
  config.vm.define "f28" do |f28|
      f28.vm.box = "bento/fedora-28"
      f28.ssh.insert_key = false
      f28.vm.network 'private_network', ip: '192.168.10.128'
      f28.vm.hostname = 'f28'
      f28.vm.provision "shell", inline: <<-SHELL
        dnf install -y python3
      SHELL
      f28.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
    end

  config.vm.define "f29" do |f29|
      f29.vm.box = "bento/fedora-29"
      f29.ssh.insert_key = false
      f29.vm.network 'private_network', ip: '192.168.10.129'
      f29.vm.hostname = 'f29'
      f29.vm.provision "shell", inline: <<-SHELL
        dnf install -y python3
      SHELL
      f29.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
    end

  config.vm.define "f30" do |f30|
      f30.vm.box = "bento/fedora-30"
      f30.ssh.insert_key = false
      f30.vm.network 'private_network', ip: '192.168.10.130'
      f30.vm.hostname = 'f30'
      f30.vm.provision "shell", inline: <<-SHELL
        dnf install -y python3
      SHELL
      f30.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
  end

  config.vm.define "f31" do |f31|
      f31.vm.box = "bento/fedora-31"
      f31.ssh.insert_key = false
      f31.vm.network 'private_network', ip: '192.168.10.131'
      f31.vm.hostname = 'f31'
      f31.vm.provision "shell", inline: <<-SHELL
        dnf install -y python3
      SHELL
      f31.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
    end

  # 202101.10 lots of mirrors are broken for f32 making package install VERY slow
  # https://superuser.com/questions/1035780/how-can-i-use-a-specific-mirror-server-in-fedora
  # try updating packages and see if that improves things (not really)
  # added fastestmirror and specific mirror
  # tried changing from fedora/32-cloud-base to another box
  config.vm.define "f32" do |f32|
    f32.vm.box = "fedora/32-cloud-base"
    f32.ssh.insert_key = false
     f32.vm.network 'private_network', ip: '192.168.10.132'
    f32.vm.hostname = 'f32'
        f32.vm.provision "shell", inline: <<-SHELL
            dnf config-manager --setopt=fastestmirror=True --save
            dnf config-manager --add-repo https://dl.fedoraproject.org/pub/fedora/linux/releases/32/Everything/x86_64/os/
            dnf config-manager --add-repo http://mirrors.kernel.org/fedora/releases/32/Everything/x86_64/os/
            dnf install -y python3
        SHELL
     f32.vm.provision "ansible" do |ansible|
       ansible.compatibility_mode = "2.0"
       ansible.playbook = "site.yaml"
       ansible.inventory_path = "./inventory"
     end
  end
  
  config.vm.define "f33" do |f33|
    f33.vm.box = "fedora/33-cloud-base"
    f33.ssh.insert_key = false
    f33.vm.network 'private_network', ip: '192.168.10.133'
    f33.vm.hostname = 'f33'
        f33.vm.provision "shell", inline: <<-SHELL
           dnf install -y python3
        SHELL
        # requires ansible_python_interpreter=/usr/bin/python3 in inventory
        f33.vm.provision "ansible" do |ansible|
            ansible.compatibility_mode = "2.0"
            ansible.playbook = "site.yaml"
            ansible.inventory_path = "./inventory"
        end
  end
  
  config.vm.define "f34" do |f34|
    f34.vm.box = "fedora/34-cloud-base"
    f34.ssh.insert_key = false
    f34.vm.network 'private_network', ip: '192.168.10.134'
    f34.vm.hostname = 'f34'
        f34.vm.provision "shell", inline: <<-SHELL
           dnf install -y python3
        SHELL
        # requires ansible_python_interpreter=/usr/bin/python3 in inventory
        f34.vm.provision "ansible" do |ansible|
          ansible.compatibility_mode = "2.0"
          ansible.playbook = "site.yaml"
          ansible.inventory_path = "./inventory"
        end
  end


  config.vm.define "u12" do |u12|
      u12.vm.box = "bento/ubuntu-12.04"
      u12.vm.network 'private_network', ip: '192.168.10.112'
      u12.vm.hostname = 'u12'
      u12.vm.provision "shell", inline: <<-SHELL
        apt-get -y install python 
      SHELL
      u12.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
    end

  config.vm.define "u14" do |u14|
      u14.vm.box = "ubuntu/trusty64"
      u14.vm.network 'private_network', ip: '192.168.10.114'
      u14.vm.hostname = 'u14'
      u14.vm.provision "shell", inline: <<-SHELL
        apt-get -y install python
      SHELL
      u14.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
  end

  config.vm.define "u16" do |u16|
      u16.vm.box = "ubuntu/xenial64"
      u16.vm.network 'private_network', ip: '192.168.10.116'
      u16.vm.hostname = 'u16'
      u16.vm.provision "shell", inline: <<-SHELL
        apt-get -y install python3
      SHELL
      u16.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
    end

  # ansible uses python3 1/7/21
  config.vm.define "u18" do |u18|
      u18.vm.box = "ubuntu/bionic64"
      u18.vm.network 'private_network', ip: '192.168.10.118'
      u18.vm.hostname = 'u18'
      u18.vm.provision "shell", inline: <<-SHELL
        apt-get -y install python3
      SHELL
      u18.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
  end

  # https://www.reddit.com/r/Ubuntu/comments/ga187h/focal64_vagrant_box_issues/
  # 1/7/21 earlier releases of focal64 didn't work with vagrant but that's now been fixed
  # requires setting ansible_python_interpreter=/usr/bin/python3 
  config.vm.define "u20" do |u20|
      u20.vm.box = "ubuntu/focal64"
      #u20.vm.box = "bento/ubuntu-20.04"
      u20.vm.network 'private_network', ip: '192.168.10.120'
      u20.vm.hostname = 'u20'
      u20.vm.provision "shell", inline: <<-SHELL
        apt-get -y install python3
      SHELL
      u20.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "site.yaml"
        ansible.inventory_path = "./inventory"
      end
  end

end
