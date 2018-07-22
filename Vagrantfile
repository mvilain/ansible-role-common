# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Vagrantfile for ansible-common-role

Vagrant.configure("2") do |config|
	# config.vm.network 'forwarded_port', guest: 80, host: 8080
	config.ssh.insert_key = false
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
		centos6.vm.box = "geerlingguy/centos6"
		centos6.vm.network 'private_network', ip: '192.168.10.106'
		centos6.vm.hostname = 'centos6'
		
		centos6.vm.provision "shell", inline: <<-SHELL
			# yum update -y
			# yum install -y https://centos6.iuscommunity.org/ius-release.rpm
			yum install -y python libselinux-python
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
		centos7.vm.box = "geerlingguy/centos7"
		centos7.vm.network 'private_network', ip: '192.168.10.107'
		centos7.vm.hostname = 'centos7'

		centos7.vm.provision "shell", inline: <<-SHELL
			# yum update -y
			# yum install -y https://centos7.iuscommunity.org/ius-release.rpm
			yum install -y python libselinux-python
		SHELL
		centos7.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end


	config.vm.define "debian8" do |debian8|
		debian8.vm.box = "geerlingguy/debian8"
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
		debian9.vm.box = "geerlingguy/debian9"
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
# bento/fedora-27
# fedora/28-cloud-base   (virtualbox, 20180425)

	# fedora21+vagrant 2 doesn't set 2nd network config correctly
	config.vm.define "fedora21" do |fedora21|
		fedora21.vm.box = "bento/fedora-21"
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
		fedora22.vm.box = "fedora22"
		#fedora22.vm.box_url = "https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/22/Cloud/x86_64/Images/Fedora-Cloud-Base-Vagrant-22-20150521.x86_64.vagrant-virtualbox.box"
		fedora22.vm.box = "bento/fedora-22"
		fedora22.vm.network 'private_network', ip: '192.168.10.122'
		fedora22.vm.hostname = 'fedora22'

		fedora22.vm.provision "shell", inline: <<-SHELL
			dnf update -y
			echo "...installing python2 (this may take a while)..."
			dnf install -y python wget libselinux-python
		SHELL
		fedora22.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	# config.vm.define "fedora27" do |fedora|
	# 	fedora.vm.box = "bento/fedora-27"
	# 	fedora.vm.network 'private_network', ip: '192.168.10.127'
	# 	fedora.vm.hostname = 'fedora27'
	# 	# python2 not previously installed
	# 	fedora.vm.provision "shell", inline: <<-SHELL
	#		dnf update -y
	# 		echo "...installing python2 (this may take a while)..."
	# 		dnf install -y python libselinux-python
	# 	SHELL
	# 	fedora.vm.provision "ansible" do |ansible|
	# 		ansible.compatibility_mode = "2.0"
	# 		ansible.playbook = "site.yml"
	# 		ansible.inventory_path = "./inventory"
	# 	end
	# end

	config.vm.define "fedora28" do |fedora|
		fedora.vm.box = "fedora/28-cloud-base"
		fedora.vm.network 'private_network', ip: '192.168.10.128'
		fedora.vm.hostname = 'fedora28'

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

# ubuntu/precise64    (virtualbox, 20170427.0.0)
# ubuntu/trusty64     (virtualbox, 20180530.1.0)
# ubuntu/xenial64     (virtualbox, 20180602.0.0)
# bento/ubuntu-17.04  (virtualbox, 201801.02.0)
# ubuntu/bionic64     (virtualbox, 20180531.0.0)

	config.vm.define "ubuntu12" do |ubuntu12|
		ubuntu12.vm.box = "geerlingguy/ubuntu1204"
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
		ubuntu14.vm.box = "geerlingguy/ubuntu1404"
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
		ubuntu16.vm.box = "geerlingguy/ubuntu1604"
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

	# config.vm.define "ubuntu17" do |ubuntu17|
	# 	ubuntu17.vm.box = "bento/ubuntu-17.04" # 17.04-needs python
	# 	ubuntu17.vm.network 'private_network', ip: '192.168.10.117'
	# 	ubuntu17.vm.hostname = 'ubuntu17'

	# 	# fix 17.04 apt database as it EOL as of Feb-2018
	# 	ubuntu17.vm.provision "shell", inline: <<-SHELL
	# 		echo "...fixing apt database..."
	# 		sed -i -e "s/archive.ubuntu.com/old-releases.ubuntu.com/" \
	# 			-e "s/security.ubuntu.com/old-releases.ubuntu.com/" \
	# 			-e "s/archive.ubuntu.com/old-releases.ubuntu.com/" /etc/apt/sources.list
	# 		apt-get update -y
	# 		apt-get install -y python
	# 	SHELL
	# 	ubuntu17.vm.provision "ansible" do |ansible|
	# 		ansible.compatibility_mode = "2.0"
	# 		ansible.playbook = "site.yml"
	# 		ansible.inventory_path = "./inventory"
	# 	end
	# end

		config.vm.define "ubuntu18" do |ubuntu18|
		ubuntu18.vm.box = "geerlingguy/ubuntu1804"
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

end
