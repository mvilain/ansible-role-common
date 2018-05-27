# packer/README.md

This directory contains files that can be used with [Packer](https://https://www.packer.io/) to build images of vagrant boxes that can be imported into virtual box.  For information on how to setup a Vagrant box file in Virtual box, see

https://www.skoblenick.com/vagrant/creating-a-custom-box-from-scratch/

https://www.engineyard.com/blog/building-a-vagrant-box

Also, many thanks to the packer [CentOS template archive](https://github.com/sbeliakou/packer-centos-template.git).  I've restructured this directory to use thier moduluar approach rather than monolithic scripts and templates.  There is also a Makefile to build various distros in Virtualbox.



Currently files in this directory are:

* **http/**

* **centos-scripts/**

  * **ubuntu1604.preseed.cfg**

    This file contains the pre-configuration answers so that the boot will not ask configuration questions when it's booted by the Packer configuration template.


  * **ubuntu1710.preseed.cfg**

    This file contains the pre-configuration answers so that the boot will not ask configuration questions when it's booted by the Packer configuration template.

  *   **vagrant.ks**

     This file contains the kickstart configuration for the CentOS systems so they will not interactively query during an installation.



* **Makefile**

  Use this file to create Vagrant boxes for CentOS 7.4-7.2, CentOS 6.8-6.9, and Ubuntu 16.04/17.10

* **vars/**

- **ubuntu1604.json**

  This is the Packer configuration template that will build a version Ubuntu 16.04 from the [distribution ISO](http://releases.ubuntu.com/16.04.4/ubuntu-16.04.4-server-amd64.iso).

- **ubuntu1710.setup.sh**

  This file contains the final configuration script that sets up the Virtual Box guest VM to make it into a Vagrant box. 

- **ubuntu1710.json**

  This is the Packer configuration template that will build a version Ubuntu 17.10.1 from the [distribution ISO](http://releases.ubuntu.com/17.10/ubuntu-17.10.1-server-amd64.iso).

- **ubuntu1710.setup.sh**

  This file contains the final configuration script that sets up the Virtual Box guest VM to make it into a Vagrant box. 

When Packer is completed the build command, 

```base
packer validate ubuntu1710.json
packer build ubuntu1710.json
```

it leaves a box file *packer_virtualbox-iso_virtualbox.box* that can be imported into Vagrant. This typically takes about 20 minutes, depending on your CPU and network bandwidth.
