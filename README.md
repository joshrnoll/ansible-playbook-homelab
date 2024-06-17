# A Collection of Ansible Playbooks for my Homelab
## Description
The goal of this repo is to automate the setup and configuration of my homelab. Still a work in progess...

All services are run in docker containers, each tied to a tailscale container for networking. Tailscale handles DNS and reverse proxying via the Tailscale Serve/Funnel feature. 

The containers are hosted on Ubuntu 22.04 VMs in Proxmox. This collection of playbooks primarily supports these VMs and the Proxmox hosts. 

The only notable exception, currently, is pihole which runs directly on an Ubuntu VM with a secondary running directly on a raspberry pi zero w.

## Usage
First, cd into the directory where you cloned the repo. Then, create a hosts.ini file

```
nano hosts.ini
```

An example hosts file is included in this repository for reference. Ensure the following groups exist:

<ul>
	<li> ubuntu
	<li> docker
	<li> uptimekuma
</ul>

Hosts in the ubuntu group will receive an initial setup with basic security hardening.

Hosts in the docker group will have docker and docker compose installed

Hosts in the uptimekuma group will have an [uptimekuma](https://uptime.kuma.pet/) container deployed. (Additional groups for additional services will be added in the future).

After you cd into directory where you cloned the repo, run this command to run the playbook:

```
ansible-playbook -i hosts.ini main.yml --ask-vault-pass
```

## Recent additions

Recently added support in the ubuntusetup playbook for install/configuring of tailscale using the [artis3n.tailscale](https://galaxy.ansible.com/ui/standalone/roles/artis3n/tailscale/) module. <br>

More info [here](./TAILSCALE.md)