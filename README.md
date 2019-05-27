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



## Appendix A -- Building your own Vagrant box with Packer

The following sites are very useful for building your own Vagrant boxes in Virtual

- https://www.engineyard.com/blog/building-a-vagrant-box
- https://www.skoblenick.com/vagrant/creating-a-custom-box-from-scratch

And this git repo is good for creating packer templates:

* https://github.com/mrlesmithjr/packer-templates.git

## Appendix B -- OS and Versions Tested

The following OS and versions have been tested:

- CentOS 6 and 7
- Debian 8 (jessie) and 9 (stretch)
- Fedora 21 - 30*
- Ubuntu 12.04 (precise) 14.04 (trusty), 16.04 (xenial), and 18.04 (bionic)



*-- Fedora Offical cloud release lacks the Virtual Box Extensions, which is not required to use this ansible role
