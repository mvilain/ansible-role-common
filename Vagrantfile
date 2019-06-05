# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Vagrantfile for ansible-common-role

Vagrant.configure("2") do |config|
	# config.vm.network 'forwarded_port', guest: 80, host: 8080
	config.vm.synced_folder '.', '/vagrant', disabled: false
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
		for i in /etc/sysconfig/network-scripts/ifcfg-eth1 /etc/sysconfig/network-scripts/ifcfg-enp0s8; do
			if [ -e ${i} ]; then echo "...displaying ${i}..."; cat ${i}; fi
		done
	SHELLALL


	config.vm.define "centos6" do |centos6|
		centos6.vm.box = "centos/6"
		centos6.ssh.insert_key = false
		centos6.vm.network 'private_network', ip: '192.168.10.106'
		centos6.vm.hostname = 'centos6'

		
		centos6.vm.provision "shell", inline: <<-SHELL
			# yum update -y
			# yum install -y https://centos6.iuscommunity.org/ius-release.rpm
			# yum install -y python libselinux-python
		SHELL
		centos6.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
			# ansible.verbose = "v"
			# ansible.raw_arguments = [""]
		end
	end

	config.vm.define "centos7" do |centos7|
		centos7.vm.box = "centos/7"
		centos7.ssh.insert_key = false
		centos7.vm.network 'private_network', ip: '192.168.10.107'
		centos7.vm.hostname = 'centos7'

		centos7.vm.provision "shell", inline: <<-SHELL
			# yum update -y
			# yum install -y https://centos7.iuscommunity.org/ius-release.rpm
			# yum install -y python libselinux-python
		SHELL
		centos7.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	config.vm.define "debian8" do |debian8|
		debian8.vm.box = "debian/jessie64"
		debian8.ssh.insert_key = false
		debian8.vm.network 'private_network', ip: '192.168.10.108'
		debian8.vm.hostname = 'debian8'
		
		debian8.vm.provision "shell", inline: <<-SHELL
			apt-get update -y
			apt-get install -y python
		SHELL
		debian8.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
			# ansible.verbose = "v"
			# ansible.raw_arguments = [""]
		end
	end

	config.vm.define "debian9" do |debian9|
		debian9.vm.box = "debian/stretch64"
		debian9.ssh.insert_key = false
		debian9.vm.network 'private_network', ip: '192.168.10.109'
		debian9.vm.hostname = 'debian9'
		
		debian9.vm.provision "shell", inline: <<-SHELL
			apt-get update -y
			apt-get install -y python
		SHELL
		debian9.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
			# ansible.verbose = "v"
			# ansible.raw_arguments = [""]
		end
	end



# bento/fedora-21        (virtualbox, 2.2.3)
# bento/fedora-22        (virtualbox, 2.2.4)
# fedora 22 archived to
# https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/22/Cloud/x86_64/Images/Fedora-Cloud-Base-Vagrant-22-20150521.x86_64.vagrant-virtualbox.box
# bento/fedora-29
# fedora/30-cloud-base   (virtualbox, v30.20190425.0)

	# fedora21+vagrant 2 doesn't set 2nd network config correctly
	config.vm.define "fedora21" do |fedora21|
		fedora21.vm.box = "bento/fedora-21"
		fedora21.ssh.insert_key = false
		fedora21.vm.network 'private_network', ip: '192.168.10.121'
		fedora21.vm.hostname = 'fedora21'

		fedora21.vm.provision "shell", inline: <<-SHELL
			echo "...fixing enp0s8..."
			sed -i -e "s/BOOTPROTO=none/BOOTPROTO=static/" /etc/sysconfig/network-scripts/ifcfg-enp0s8
			systemctl restart network
			# yum update -y
			echo "...installing python2 (this may take a while)..."
			yum install -y python wget libselinux-python selinux-policy-default
		SHELL
		fedora21.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	# these two versions are tested because 21 still used yum while 22 used dnf
	config.vm.define "fedora22" do |fedora22|
		#fedora22.vm.box = "fedora22"
		#fedora22.vm.box_url = "https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/22/Cloud/x86_64/Images/Fedora-Cloud-Base-Vagrant-22-20150521.x86_64.vagrant-virtualbox.box"
		fedora22.vm.box = "bento/fedora-22"
		fedora22.ssh.insert_key = false
		fedora22.vm.network 'private_network', ip: '192.168.10.122'
		fedora22.vm.hostname = 'fedora22'

		fedora22.vm.provision "shell", inline: <<-SHELL
			#dnf update -y
			echo "...installing python2 (this may take a while)..."
			dnf install -y python wget libselinux-python
		SHELL
		fedora22.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	# virtualbox runs the older 5.0 on Fedora 23 and below
	# so test that it works
	config.vm.define "fedora23" do |fedora23|
		fedora23.vm.box = "bento/fedora-23"
		fedora23.ssh.insert_key = false
		fedora23.vm.network 'private_network', ip: '192.168.10.123'
		fedora23.vm.hostname = 'fedora23'

		fedora23.vm.provision "shell", inline: <<-SHELL
			#dnf update -y
			echo "...installing python2 (this may take a while)..."
			dnf install -y python wget libselinux-python
		SHELL
		fedora23.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	config.vm.define "fedora29" do |fedora|
		fedora.vm.box = "fedora/29-cloud-base"
		fedora.ssh.insert_key = false
		fedora.vm.network 'private_network', ip: '192.168.10.129'
		fedora.vm.hostname = 'fedora29'

		# python2 and virtual box extensions not installed
		fedora.vm.provision "shell", inline: <<-SHELL
			# dnf update -y
			echo "...installing python2 (this may take a while)..."
			dnf install -y python wget libselinux-python
		SHELL
		fedora.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	config.vm.define "fedora30" do |fedora|
		fedora.vm.box = "fedora/30-cloud-base"
		fedora.ssh.insert_key = false
		fedora.vm.network 'private_network', ip: '192.168.10.130'
		fedora.vm.hostname = 'fedora30'

		# python3 and virtual box extensions not installed
		# requires ansible_python_interpreter=/usr/bin/python3 in inventory
		fedora.vm.provision "shell", inline: <<-SHELL
			# dnf update -y
			echo "...installing python3 (this may take a while)..."
			dnf install -y python3 wget libselinux-python3
		SHELL
		fedora.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

# ubuntu/precise64    (virtualbox, 20170427.0.0)
# ubuntu/trusty64     (virtualbox, 20190429.0.1)
# ubuntu/xenial64     (virtualbox, 20190530.3.0)
# ubuntu/bionic64     (virtualbox, 20190531.0.0)

	config.vm.define "ubuntu12" do |ubuntu12|
		ubuntu12.vm.box = "ubuntu/precise64"
		ubuntu12.ssh.insert_key = false
		ubuntu12.vm.network 'private_network', ip: '192.168.10.112'
		ubuntu12.vm.hostname = 'ubuntu12'

		ubuntu12.vm.provision "shell", inline: <<-SHELL
			apt-get update -y
			apt-get install -y python
		SHELL
		ubuntu12.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	config.vm.define "ubuntu14" do |ubuntu14|
		ubuntu14.vm.box = "ubuntu/trusty64"
		ubuntu14.ssh.insert_key = false
		ubuntu14.vm.network 'private_network', ip: '192.168.10.114'
		ubuntu14.vm.hostname = 'ubuntu14'

		ubuntu14.vm.provision "shell", inline: <<-SHELL
			apt-get update -y
			apt-get install -y python
		SHELL
		ubuntu14.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	config.vm.define "ubuntu16" do |ubuntu16|
		ubuntu16.vm.box = "ubuntu/xenial64"
		ubuntu16.ssh.insert_key = false
		ubuntu16.vm.network 'private_network', ip: '192.168.10.116'
		ubuntu16.vm.hostname = 'ubuntu16'

		ubuntu16.vm.provision "shell", inline: <<-SHELL
			apt-get update -y
			apt-get install -y python
		SHELL
		ubuntu16.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	config.vm.define "ubuntu18" do |ubuntu18|
		ubuntu18.vm.box = "ubuntu/bionic64"
		ubuntu18.ssh.insert_key = false
		ubuntu18.vm.network 'private_network', ip: '192.168.10.118'
		ubuntu18.vm.hostname = 'ubuntu18'

		ubuntu18.vm.provision "shell", inline: <<-SHELL
			apt-get update -y
			apt-get install -y python
			apt -y autoremove
		SHELL
		ubuntu18.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	# https://app.vagrantup.com/AndrewDryga/boxes/vagrant-box-osx
	# download box via (this will take 2 hours at 28MB/s)
	# vagrant box add https://vagrant-osx.nyc3.digitaloceanspaces.com/osx-sierra-0.3.1.box --name macos1011
	config.vm.define "macos1011" do |macos1011|
		macos1011.vm.box = "macos1011"
		macos1011.ssh.insert_key = false
		macos1011.vm.network 'private_network', ip: '192.168.10.211'
		macos1011.vm.hostname = 'macos1011'

		# this box already has homebrew and homebrew cask already installed
		macos1011.vm.provision "shell", inline: <<-SHELL
			# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		SHELL
		macos1011.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
			# ansible.verbose = "v"
			# ansible.raw_arguments = [""]
		end
	end

end
