vagrant
=========

This role installs the vagrant binary on either a local or remote machine. It will install on a CentOS, Debian, or MacOS system.

Requirements
------------

This role assumes that the vagrant application will be running on x86 64-bit systems.


Role Variables
--------------

The following default variables are define:

- **vagrant_version** -- this is the default version of vagrant to download and install
- **vagrant_url** --  this is the base part of HashiCorp's vagrant URL
- **vagrant_dest** -- this is the destination directory where the vagrant binary will be installed

Dependencies
------------

none.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { vagrant }

License
-------

BSD
