ansible
=========

This role installs ansible on either a local or remote machine. It will install on a 
CentOS [678], Debian [9|10|11], Ubuntu 14.04 to 22.04 or MacOS system. 
A lot of this code comes from Guy Geeringling's Ansible and EPEL roles.

https://github.com/geerlingguy/ansible-role-ansible
https://github.com/geerlingguy/ansible-role-repo-epel

Thanks Guy!

Requirements
------------

This role assumes that the python 2.8 and ansible application will be running on x86 64-bit systems.  This role most likely won't work behind a proxy as the modules can't connect via https.


Role Variables
--------------

none.

Dependencies
------------

none.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - ansible

License
-------

BSD
