virtualbox
=========

This role installs virtualbox on either a local or remote machine. 
It will install on a CentOS [678], Debian [9|10|11], or Fedora 21-35.

Requirements
------------

This role assumes that the virtualbox application will be running on 
x86 64-bit systems.  This role most likely won't work behind a proxy as 
the modules can't connect via https.


Role Variables
--------------

The following default variables are define:

- **vb_version** -- default version of Virtual Box release...change once and
all the URLs change

- **deb_vb_keyurl** -- URL for the Ubuntu 18.04+, Debian 9+ install repo
- **deb_vb_key** -- URL for the Debian/Ubuntu PGP key for the signed deb file
- **deb_vb_old_key** -- URL for the Debian/Ubuntu PGP key for older releases 
(< Ubuntu 18.04, < Debian 8)
- **rhel_vb_keyurl** -- URL for the RHEL CentOS repo
- **rhel_vb_key** -- URL for the RHEL CentOS key file

- **macos_vb_url** -- URL for the MacOS DMG file (currently untested)

Dependencies
------------

As of 7/22/22, there are no dependancies

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables 
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - virtualbox

License
-------

BSD
