virtualbox
=========

This role installs virtualbox on either a local or remote machine. It will install on a CentOS [67], Debian [8|9|, or MacOS system.

Requirements
------------

This role assumes that the virtualbox application will be running on x86 64-bit systems.


Role Variables
--------------

The following default variables are define:

- **vb_version** -- default version of Virtual Box release...change once and all the URLs change
- **u1804_vb_url** -- URL for the Ubuntu 18.04/debian10 deb file
- **deb9_vb_url** -- URL for the Debian9 install file
- **deb8_vb_url** -- URL for the Debian8 deb file
- **deb_vb_key** -- URL for the Debian/Ubuntu PGP key for the signed deb file

- **fed28_vb_url** --  URL for the RHEL Fedora 26,27,28 rpm file
- **rhel7_vb_url** -- URL for the RHEL CentOS7 rpm file
- **rhel6_vb_url** -- URL for the RHEL CentOS6 rpm file
- **rpm_vb_key** -- URL for the Fedora/RHEL6/RHEL7 PGP key for the signed RPM file

- **macos_vb_url** -- URL for the MacOS DMG file

Dependencies
------------

none.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { virtualbox }

License
-------

BSD
