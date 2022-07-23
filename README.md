# ansible-role-common

This is a basic layout for an ansible project that can be expanded to support 
a site with a common set of utilities to be run on all hosts.  It can be tested 
using Vagrant.


## How to use

To use this role inside of ansible, 

* add the **common/** directory tree to your roles/ directory inside your 
ansible repository
* edit the inventory file to use the common role for every host (or specific hosts)
* to add packages, services, files, etc. to the common role:
  - modify variable *base_packages* in **roles/common/defaults/main.yml**
  - modify type or distro files in **roles/common/vars** for OS-specific stuff


## Using Vagrant and Virtual Box for testing

This repo works best by typing `vagrant up` and watching the various boxes 
run one by one.  But that can be tedious.  I've changed the vagrant boxes from
the standard ubuntu and fedora distros in which some don't have python already
installed to ones that run ansible without any prior provisioning.

Both `vagrant up` and `vagrant up --no-provision; ansible-playbook site.yml` work for:
- Amazon Linux 2
- AlmaLinux 8 and 9 (a8, a9)
- CentOS 6 and 7 (c6, c7)
- RockyLinux 8 and 9 (r8, r9)
- Debian 9 and 10 (d9, d10)
- fedora 22
- fedora 23
- fedora 29
- fedora 30
- fedora 31
- fedora 32
- fedora 33
- fedora 34
- fedora 35
- ubuntu 12.04
- ubuntu 14.04
- ubuntu 16.04
- ubuntu 18.04
- ubuntu 20.04
- ubuntu 21.11

Only `vagrant up` works for
- fedora 21 (requires vagrant to provision correctly with 2nd NIC and install python)


## Appendix A -- Building your own Vagrant box with Packer

The following sites are very useful for building your own Vagrant boxes in Virtual

- https://www.engineyard.com/blog/building-a-vagrant-box
- https://www.skoblenick.com/vagrant/creating-a-custom-box-from-scratch

And this git repo is good for creating packer templates:

* https://github.com/mrlesmithjr/packer-templates.git

## Appendix B -- OS and Versions Tested

The following OS and versions have been tested:

- Amazon Linux 2
- AlmaLinux 8 and 9
- CentOS 6, 7
- RockyLinux 8 and 9
- Debian 9 (stretch 64-bit), Debian 10 (buster 64-bit), Debian 11 (trusy 64-bit)
- Fedora 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35
- Ubuntu 14.04 (trusty), 16.04 (xenial), 18.04 (bionic), 20.04 (focal), 22.04 (jammy)

Note: 12/7/21
- virtualbox 6.1.28+ does ##not## work with Vagrant 2.18+
- ubuntu 21.11 does not have a working install of ansible, virtualbox

Note: 7/23/22
- virtualbox 6.1.36 does not install on either Almalinux 9 or RockyLinux 9