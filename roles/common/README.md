Role Name
=========

A brief description of the role goes here.

Requirements
------------

This module may use SELinux commands which require an extra python module beyond python V2.  Be sure the target systems have this installed as part of the Vagrant file.

Debian and Ubuntu distributions do not use the SELinux features as the ansible modules for them are untested. 

Fedora 21 does not install SELinux by default, so the selinux-policy-default package must be installed by Vagrant prior to provisioning with ansible.


Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
