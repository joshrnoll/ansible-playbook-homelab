![](/nollhomelab-logo.svg)

# An Ansible Playbook for Automating my Homelab
The goal of this playbook is to be a **One-Command-Homelab.** Its purpose in life is to automate the setup and configuration of my homelab by running one command:

```
./run.sh
```
Additionally, this giant playbook defines my homelab almost entirely. Effectively running my ***Homelab as Code - HaC***.

It's a constant work in progress...

## Features
Click [here](./FEATURES.md) for a comprehensive list of features and their status.

## Description
All infrastructure is provisioned and configured using ansible playbooks which leverage custom roles from my [homelab collection on ansible galaxy](https://github.com/joshrnoll/ansible-collection-homelab). Playbooks are called with a simple bash script. 

### Server Configuration
Most of my servers are Ubuntu 22.04 VMs in Proxmox. This playbook currently supports configuring both Ubuntu 22.04 and Fedora 40 servers (VMs or bare metal). Support for other OSes may come in the future.

***What configurations are made on the servers?*** -- See [FEATURES.md](FEATURES.md)

### Services Installed
#### Tailscale
See [***tailscale-info***](https://github.com/joshrnoll/tailscale-info)

#### Docker
The playbook goes a bit beyond simply installing Docker. It will also deploy [Portainer](https://www.portainer.io/), which provides an intuitive web GUI for managing containers, and [Nautical Backup](https://minituff.github.io/nautical-backup/), a container that automatically backs up all Docker container bind mounts from the host to a mounted SMB share via rsync. 

### Containers Deployed
All services are run in docker containers, each tied to a tailscale container for networking. This is sometimes referred to as a "sidecar" container, as the tailscale container does not provide any services itself and must have another container connected to it to be useful. 

For more info see [***tailscale-info***](https://github.com/joshrnoll/tailscale-info)

# Usage
Before attempting to use this playbook for your own homelab, ensure that you have read the description above so that you will have an understanding of how it will build containers. 

## Prerequisites

##### Using this playbook assumes you have the following
<ul>
<li>Tailscale account</li>
<li>HTTPS enabled on your Tailscale account</li>
<li>Two OAuth Clients created in the Tailscale admin console (one for containers and one for servers)</li>
<li>Two tags created in your Tailscale config file (containers and servers)</li>
<li>A Proxmox cluster</li>
</ul>

First, you'll need an inventory file. This can be written in either YAML or INI format. See the [Ansible docs on building your inventory](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html) for more info.

An example hosts file ([EXAMPLE_production.yml](./EXAMPLE_production.yml)) is included in this repository for reference. Ensure the following groups exist:

<ul>
	<li> proxmox_hosts -- <em>Each of your individual proxmox hosts</em>
	<li> proxmox_api -- <em> One of your proxmox hosts. You can use any of them, but I recommend using the one that you normally use to log in to the web interface with. </em>
	<li> ubuntu
	<li> fedora
	<li> pihole
	<li> docker
	<li> One group for each container being run, named after the container. If the container name contains a hyphen (such as uptime-kuma) then it should be replaced with an underscore (uptime_kuma)
</ul>

## Creating a variable file with Ansible Vault
You must have a file in the vars directory that contains all of your sensitive variables. It is recommended to encrypt this file with Ansible Vault.
```
cd vars
ansible-vault create secrets.yml
```