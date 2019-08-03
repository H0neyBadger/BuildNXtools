Auto fusee gelee
================

Simple role to install a fusee gelee systemd service. 
The aim is to run a custom service as soon as the nintendo switch is detected by the system's rules.

Requirements
------------

git and python3-venv

Role Variables
--------------

* git_url : "https://github.com/Qyriad/fusee-launcher.git"
* project_directory: "/root/fusee-launcher"
* payload_remote_path: "{{ (project_directory + '/payload.bin') | realpath }}"
* payload_path: "./hekate/output/hekate.bin"


Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

    - hosts: all
      roles:
         - { role: auto_fusee_gelee }

License
-------

GNU GENERAL PUBLIC LICENSE 3
