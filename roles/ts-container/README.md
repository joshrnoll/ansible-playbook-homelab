Role Name
=========

A brief description of the role goes here.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------
| Variable | Description | Accepted Values | Example |
| :--- | :--- | :--- | :--- |
| **authkey:** | Your tailscale authkey or oauth client secret | If passed as a variable, this must be passed as a dictionary value | ***figure out how to put example codeblock in markdown table*** |
| **service_name:** | The name of your service. This can be whatever you want to call the container. This will also be used to format the names of the container's data folder for its bind mounts. | **String** | my-plex-server |

Dependencies
------------
- **Docker** is required to be installed on the target node
- You must have a Tailscale [Authey](https://tailscale.com/kb/1085/auth-keys) or [Oauth client](https://tailscale.com/kb/1215/oauth-clients) created.


Example Playbook
----------------

This example installs Uptime Kuma as a non-public (not exposed to the internet) container. It is not using userspace networking and has no environment variables provided
```
---
- name: Install Uptime Kuma
  hosts: uptime-kuma

  tasks:  
    - name: Install Uptime Kuma 
      include_role:
        name: ../../roles/ts-container
      vars:
        authkey: "{{ tailscale_containers_oauth_key['key'] }}"
        service_name: uptime-kuma
        container_image: louislam/uptime-kuma
        container_tag: latest
        serve_port: 3001
        userspace_networking: "false"
        public: false
        container_volumes:
          - /home/{{ ansible_user }}/{{ container_name }}/app:/app/data
```
This example installs plex as a public (exposed to the internet) container. It has several environment variables provided and is not using userspace networking. 
```
- name: Install plex
  hosts: plex

  tasks:
    - name: Include variables
      include_vars: 
        dir: ../../vars

    - name: Install plex
          include_role:
            name: ../../roles/ts-container
          vars:
            authkey: "{{ tailscale_containers_oauth_key['key'] }}"
            service_name: plex
            container_image: lscr.io/linuxserver/plex
            container_tag: arm64v8-latest
            https_container: true
            serve_port: 32400
            userspace_networking: "false"
            public: true
            container_volumes:
              - /home/{{ ansible_user }}/plex/config:/config
              - /home/{{ ansible_user }}/media/media:/media
            env_vars:
              PUID: "1000"
              PGID: "999"
              TZ: "America/New_York"
              Version: "docker"
```

License
-------

BSD

Author Information
------------------

Josh Noll
https://www.joshrnoll.com
