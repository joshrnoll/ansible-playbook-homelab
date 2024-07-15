# The One-Command-Homelab
The goal of the **One-Command-Homelab** is to automate the setup and configuration of my homelab by running one command:

```
./run.sh
```
It's a constant work in progress.

## Features
Click [here](./FEATURES.md) for a comprehensive list of features and their status.

## Description
All infrastructure is provisioned and configured using ansible playbooks that are called with a simple bash script. 

### Server Configuration
Most of my servers are Ubuntu 22.04 VMs in Proxmox. This playbook currently supports configuring both Ubuntu and Fedora servers (VMs or bare metal). Support for other OSes may come in the future.

*What configurations are made on the servers?*
See [FEATURES.md](FEATURES.md)

### Services Installed
#### Tailscale
See [TAILSCALE.md](TAILSCALE.md)

#### Docker
The playbook goes a bit beyond simply installing Docker. It will also deploy [Portainer](https://www.portainer.io/), which provides an intuitive web GUI for managing contianers, and [Nautical Backup](https://minituff.github.io/nautical-backup/), a container that automaatically backs up all Docker container volumes on the host. 

### Containers Deployed
All services are run in docker containers, each tied to a tailscale container for networking. This is sometimes referred to as a "sidecar" container, as the tailscale container does not provide any services itself and must have another container connected to it to be useful. 

Tailscale handles DNS and reverse proxying via the [Tailscale Serve/Funnel feature](https://tailscale.com/kb/1312/serve). This allows us to connect to, for example, an Uptime Kuma instance over the URL https://uptime-kuma.tailnet-name.ts.net rather than something like http://192.168.0.100:3001 over the local network. This provides the added benefit of being able to access your services from anywhere over a secure connection with authentication built in.

**A visualization of how this works:**
![ts-container](ts-container.svg)

#### Can I pick my own subdomain?
Yes and no. You can't bring your own domain (one that you've purchased from a domain registrar).The subdomain is based off of your tailnet name. Your default tailnet name will be in the form of tail-NNNN.ts.net or tailnet-NNNN.ts.net where N is a random number or letter. 

ex. **tailfe8c.ts.net**

If you want something more human readable, [you can "roll" for a "fun" tailnet name](https://tailscale.com/kb/1217/tailnet-name#creating-a-fun-tailnet-name). Something like **cat-crocodile.ts.net.**

***IMPORTANT***
If using a "fun" tailnet name, it will become permenant once you enable HTTPS certificates to use the Tailscale Serve and Funnel features. You can't re-roll for a new name after that has been enabled.

# Usage
Before attempting to use this playbook for your own homelab, ensure that you have read the description above so that you will have an understanding for how it will build contianers. 
## Prerequisites

##### Using this playbook assumes you have the following
<ul>
<li>Tailscale account</li>
<li>HTTPS enabled on your Tailscale account</li>
<li>Two OAuth Clients created in the Tailscale admin console (one for containers and one for servers)</li>
<li>Two tags created in your Tailscale config file (containers and servers)</li>
<li>A Proxmox cluster</li>
</ul>
First, you'll need an inventory file. This can be written in either YAML or INI format. See the [Ansible docs - building your inventory](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html) for more info.

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
You must have a file in the vars directory that contains all of your variables. It is recommended to encrypt this file with Ansible Vault
```
cd vars
ansible-vault create secrets.yml
```
## Recent additions

Recently added support in the ubuntusetup playbook for install/configuring of tailscale using the [artis3n.tailscale](https://galaxy.ansible.com/ui/standalone/roles/artis3n/tailscale/) module. <br>

More info [here](./TAILSCALE.md)