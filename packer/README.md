#packer/README.md

This directory contains files that can be used with [Packer](https://https://www.packer.io/) to build images of vagrant boxes that can be imported into virtual box.

Currently files in this directory are:

- **ubuntu1710.json**

  This is the Packer configuration template that will build a version Ubuntu 17.10.1 from the [distribution ISO](http://releases.ubuntu.com/17.10/ubuntu-17.10.1-server-amd64.iso).

- **ubuntu1710.preseed.cfg**

  This file contains the pre-configuration answers so that the boot will not ask configuration questions when it's booted by the Packer configuration template.

- **ubuntu1710.setup.sh**

  This file contains the final configuration script that sets up the Virtual Box guest VM to make it into a Vagrant box. See

  https://www.skoblenick.com/vagrant/creating-a-custom-box-from-scratch/

  https://www.engineyard.com/blog/building-a-vagrant-box

When Packer is completed the build command, 

```base
packer validate ubuntu1710.json
packer build ubuntu1710.json
```

it leaves a box file *packer_virtualbox-iso_virtualbox.box* that can be imported into Vagrant. This typically takes about 20 minutes, depending on your CPU and network bandwidth.