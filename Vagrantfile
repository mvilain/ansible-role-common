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
# 		for i in /etc/sysconfig/network-scripts/ifcfg-eth1 /etc/sysconfig/network-scripts/ifcfg-enp0s8; do
# 			if [ -e ${i} ]; then echo "...displaying ${i}..."; cat ${i}; fi
# 		done
	SHELLALL


	config.vm.define "c6" do |c6|
		c6.vm.box = "centos/6"
# 		c6.vm.box = "geerlingguy/centos6"
		c6.ssh.insert_key = false
		c6.vm.network 'private_network', ip: '192.168.10.106'
		c6.vm.hostname = 'centos6'

		c6.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
			# ansible.verbose = "v"
			# ansible.raw_arguments = [""]
		end
	end

	config.vm.define "c7" do |c7|
		c7.vm.box = "centos/7"
# 		c7.vm.box = "geerlingguy/centos7"
		c7.ssh.insert_key = false
		c7.vm.network 'private_network', ip: '192.168.10.107'
		c7.vm.hostname = 'centos7'

		c7.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	config.vm.define "d9" do |d9|
		d9.vm.box = "debian/stretch64"
		d9.ssh.insert_key = false
		d9.vm.network 'private_network', ip: '192.168.10.109'
		d9.vm.hostname = 'debian9'
		
		d9.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	config.vm.define "d10" do |d10|
		d10.vm.box = "debian/buster64"
		d10.ssh.insert_key = false
		d10.vm.network 'private_network', ip: '192.168.10.110'
		d10.vm.hostname = 'debian10'
		
		d10.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end


	# fedora-21+vagrant doesn't set 2nd network config correctly
	config.vm.define "f21" do |f21|
		f21.vm.box = "bento/fedora-21"
		f21.ssh.insert_key = false
		f21.vm.network 'private_network', ip: '192.168.10.121'
		f21.vm.hostname = 'f21'

		f21.vm.provision "shell", inline: <<-SHELL
			echo "...fixing enp0s8..."
			sed -i -e "s/BOOTPROTO=none/BOOTPROTO=static/" /etc/sysconfig/network-scripts/ifcfg-enp0s8
			echo "...restarting network..."
			systemctl restart network
			sleep 10
			systemctl restart network
			ip addr
			for i in /etc/sysconfig/network-scripts/ifcfg-eth1 /etc/sysconfig/network-scripts/ifcfg-enp0s8; do
				if [ -e ${i} ]; then echo "...displaying ${i}..."; cat ${i}; fi
		done
			#yum update -y
			echo "...installing python2 (this may take a while)..."
			yum install -y python wget libselinux-python selinux-policy-default
		SHELL
		f21.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	# these two versions are tested because 21 still used yum while 22 used dnf
	config.vm.define "f22" do |f22|
		#f22.vm.box = "f22"
		f22.vm.box = "bento/fedora-22"
		f22.ssh.insert_key = false
		f22.vm.network 'private_network', ip: '192.168.10.122'
		f22.vm.hostname = 'f22'

		f22.vm.provision "shell", inline: <<-SHELL
			#dnf update -y
			echo "...installing python2 (this may take a while)..."
			dnf install -y python wget libselinux-python
		SHELL
		f22.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	# virtualbox runs the older 5.0 on Fedora 23 and below
	# so test that it works
	config.vm.define "f23" do |f23|
		f23.vm.box = "bento/fedora-23"
		f23.ssh.insert_key = false
		f23.vm.network 'private_network', ip: '192.168.10.123'
		f23.vm.hostname = 'f23'

		f23.vm.provision "shell", inline: <<-SHELL
			#dnf update -y
			echo "...installing python2 (this may take a while)..."
			dnf install -y python wget libselinux-python
		SHELL
		f23.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	config.vm.define "f29" do |f29|
		f29.vm.box = "fedora/29-cloud-base"
# 		f29.vm.box = "bento/fedora-29"
		f29.ssh.insert_key = false
		f29.vm.network 'private_network', ip: '192.168.10.129'
		f29.vm.hostname = 'f29'

		# python2 and virtual box extensions not installed
		f29.vm.provision "shell", inline: <<-SHELL
			# dnf update -y
			echo "...installing python2 (this may take a while)..."
			dnf install -y python wget libselinux-python
		SHELL
		f29.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	config.vm.define "f30" do |f30|
		f30.vm.box = "fedora/30-cloud-base"
# 		f30.vm.box = "bento/fedora-30"
		f30.ssh.insert_key = false
		f30.vm.network 'private_network', ip: '192.168.10.130'
		f30.vm.hostname = 'fedora30'

		# python3 and virtual box extensions not installed
		# requires ansible_python_interpreter=/usr/bin/python3 in inventory
		f30.vm.provision "shell", inline: <<-SHELL
			# dnf update -y
			echo "...installing python3 (this may take a while)..."
			dnf install -y python3 wget libselinux-python3
		SHELL
		f30.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	config.vm.define "u12" do |u12|
		u12.vm.box = "ubuntu/precise64"
# 		u12.vm.box = "geerlingguy/ubuntu1204"
		u12.ssh.insert_key = false
		u12.vm.network 'private_network', ip: '192.168.10.112'
		u12.vm.hostname = 'u12'

		u12.vm.provision "shell", inline: <<-SHELL
			apt-get update -y
			apt-get install -y python
		SHELL
		u12.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	config.vm.define "u14" do |u14|
		u14.vm.box = "ubuntu/trusty64"
# 		u14.vm.box = "geerlingguy/ubuntu1404"
		u14.ssh.insert_key = false
		u14.vm.network 'private_network', ip: '192.168.10.114'
		u14.vm.hostname = 'u14'

		u14.vm.provision "shell", inline: <<-SHELL
			apt-get update -y
			apt-get install -y python
		SHELL
		u14.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	config.vm.define "u16" do |u16|
# 		u16.vm.box = "ubuntu/xenial64"
		u16.vm.box = "geerlingguy/ubuntu1604"
		u16.ssh.insert_key = false
		u16.vm.network 'private_network', ip: '192.168.10.116'
		u16.vm.hostname = 'u16'

		u16.vm.provision "shell", inline: <<-SHELL
			apt-get update -y
			apt-get install -y python
		SHELL
		u16.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

	config.vm.define "u18" do |u18|
# 		u18.vm.box = "ubuntu/bionic64"
		u18.vm.box = "geerlingguy/ubuntu1804"
		u18.ssh.insert_key = false
		u18.vm.network 'private_network', ip: '192.168.10.118'
		u18.vm.hostname = 'u18'

		u18.vm.provision "shell", inline: <<-SHELL
			apt-get update -y
			apt-get install -y python
			apt -y autoremove
		SHELL
		u18.vm.provision "ansible" do |ansible|
			ansible.compatibility_mode = "2.0"
			ansible.playbook = "site.yml"
			ansible.inventory_path = "./inventory"
		end
	end

end
