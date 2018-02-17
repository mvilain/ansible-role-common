#!/bin/bash
# setup vagrant environment once machine has booted
# https://www.skoblenick.com/vagrant/creating-a-custom-box-from-scratch/
# https://www.engineyard.com/blog/building-a-vagrant-box

[ $EUID -ne 0 ] && echo "not root" && exit

echo "---------- `date` setting sudoers.d/vagrant"
echo 'vagrant ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/vagrant

echo "---------- `date` setting up .ssh/"
mkdir -p /home/vagrant/.ssh 
chmod 0700 /home/vagrant/.ssh
wget --no-check-certificate -q \
	https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub \
	-O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh/

echo "---------- `date` setting up vagrant public key"
sed -i -e 's/^#Port 22/Port 22/' \
	-e 's/^#PubKeyAuthentication yes/PubKeyAuthentication yes/' \
	-e 's/^#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config
echo "AuthorizedKeysFile %h/.ssh/authorized_keys" >> /etc/ssh/sshd_config
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
sleep 10;
egrep -e "Port 22" \
	-e "PubKeyAuthentication yes" \
	-e "PermitEmptyPasswords no" \
	-e "AuthorizedKeysFile %h" \
	-e "PasswordAuthentication no" /etc/ssh/sshd_config

echo "---------- `date` updating to non-graphic boot"
sed -i -e "s/ quiet splash/text/" /etc/default/grub
update-grub

echo "---------- `date` mounting VBoxGuestAdditions"
ls -la /home/vagrant/VBoxGuestAdditions.iso
mount -r ./VBoxGuestAdditions.iso /mnt
pushd /mnt
ls -l VBoxLinuxAdditions.run

echo "---------- `date` running VBoxGuestAdditions (failing to load vboxsf is OK)"
./VBoxLinuxAdditions.run

echo "---------- `date` zeroing out disk space"
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

exit
