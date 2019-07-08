# ansible-common-role

This is a basic layout for an ansible project that can be expanded to support a site with a common set of utilities to be run on all hosts.  It can be tested using Vagrant.


## How to use

To use this role inside of ansible, 

* add the **common/** directory tree to your roles/ directory inside your ansible repository
* edit your inventory file to use the common role for every host (or specific hosts)
* to add packages, services, files, etc. to the common role:
  - modify variable *base_packages* in **roles/common/defaults/main.yml**
  - modify type or distro files in **roles/common/vars** for OS-specific stuff


## Using Vagrant and Virtual Box for testing

This repo works best by typing `vagrant up` and watching the various boxes 
run one by one.  But that can be tedious.  I've changed the vagrant boxes from
the standard ubuntu and fedora distros in which some don't have python already
installed to ones that run ansible without any prior provisioning.

Both `vagrant up` and `vagrant up --no-provision; ansible-playbook site.yml` work for:
- CentOS 6 and 7 (c6, c7)
- Debian 9 and 10 (d9, d10)
- fedora 22
- fedora 23
- fedora 29
- fedora 30

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

- CentOS 6 and 7
- Debian 9 (stretch 64-bit) and Debian 10 (buster 64-bit)
- Fedora 21, 22, 23, 29, 30
- Ubuntu 12.04 (precise) 14.04 (trusty), 16.04 (xenial), and 18.04 (bionic)
