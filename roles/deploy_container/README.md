deploy_container
=========

Deploys a container using joshrnoll.homelab.tailscale_container role. Traefik labels added with option for forward auth directive via Authentik.

Requirements
------------

Traefik and Authentik deployed. Traefik-kop and redis required if container is deployed on a different host than Traefik. 

Role Variables
--------------

```YAML
# Defaults
deploy_container_host_group_name: nginx
deploy_container_service_name: nginx
deploy_container_service_image: nginx
deploy_container_service_tag: latest
deploy_container_service_port: "80" # Must be quoted -- ex. "80" not 80
deploy_container_service_scheme: http # http or https
deploy_container_forward_auth: false

# No defaults
deploy_container_tailnet_name: mytailnet.ts.net
deploy_container_oauth_client_secret: <oauth-client-secret>
deploy_container_domain_name: mydomain.com
deploy_container_cloudflare_email: myemail@gmail.com
deploy_container_cloudflare_api_token: <my-api-token>
deploy_container_volumes: <volumes-in-list-format>
deploy_container_env_vars: <volumes-in-dict-format>
deploy_container_commands: "echo 'startup commands go here'"

```

Dependencies
------------

- joshrnoll.homelab.tailscale_container

Example Playbook
----------------

```YAML
- name: Deploy {{ service_name }}
  hosts: "{{ host_group_name }}"
  vars:
    service_name: uptime-kuma
    host_group_name: uptime_kuma

  tasks:
    - name: Include vars
      ansible.builtin.include_vars:
        dir: "{{ root_playbook_dir }}/vars"

    - name: Deploy container
      ansible.builtin.include_role:
        name: "{{ root_playbook_dir }}/roles/deploy_container"
      vars:
        deploy_container_service_image: louislam/uptime-kuma
        deploy_container_service_tag: latest
        deploy_container_service_port: "3001" # Must be quoted -- ex. "80" not 80
        deploy_container_service_scheme: http # http or https
        deploy_container_forward_auth: false
        deploy_container_tailnet_name: "{{ tailnet_name }}"
        deploy_container_oauth_client_secret: "{{ tailscale_containers_oauth_client['secret'] }}"
        deploy_container_domain_name: "{{ domain_name }}"
        deploy_container_cloudflare_email: "{{ cloudflare_email }}"
        deploy_container_cloudflare_api_token: "{{ cloudflare_api_token }}"
```

License
-------

MIT

Author Information
------------------
Josh Noll

https://joshrnoll.com
