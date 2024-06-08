Role Name
=========

A brief description of the role goes here.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

### **container_name**: the name of your container
### **serve_port**: the port that should be proxied by tailscale serve

Dependencies
------------

tailscale_sidecar

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers-running-plex
      roles:
        - role: container
          vars:
            container_name: plex
            serve_port: 32400
            userspace_networking: false
            public: true
            volumes:
              - /home/{{ ansible_user }}/plex/config:/config
              - /home/{{ ansible_user }}/media/media:/media
            env_vars:
              PUID: "1000"
              PGID: "999"
              TZ: "America/New_York"
              Version: "docker"
          

License
-------

MIT

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
