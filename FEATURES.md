# Features
The following is a list of features and their current status. 
## Key
| Icon | Meaning|
| --- | --- |
| ❌ | Planned feature that is not being worked on yet |
| ✅ | Fully supported feature |
| 🚧 | Feature is not fully supported yet, but is actively being worked on |
#### Proxmox Hosts
Configurations made by this playbook for Proxmox host machines
| Feature | Status |
| --- | --- |
| Copy ssh key to server | ✅ |
| Install a list of desired packages | ✅ |
| Create Ceph pool and OSDs for shared VM storage| ❌ |
| Create cluster and add hosts to cluster | ❌ |
| Create cloud-init VM template | ✅ |
| Create desired VMs on Proxmox Cluster | ✅
#### Ubuntu Servers
Configurations made by this playbook for Ubuntu servers (VMs or bare metal)
| Feature | Status |
| --- | --- |
| Create admin user with sudo privileges | ✅ |
| Copy ssh key to server | ✅ |
| Install a list of desired packages | ✅ |
| Configure ufw firewall to allow SSH access and deny all other connections by default | ✅ |
#### Fedora Servers
Configurations made by this playbook for Fedora servers (VMs or bare metal)
| Feature | Status |
| --- | --- |
| Create admin user with sudo privileges | ✅ |
| Copy ssh key to server | ✅ |
| Install a list of desired packages | ✅ |
| Configure firewalld to allow SSH access and deny all other connections by default| ✅ |
#### Services
Services installed by this playbook.
| Service | Description | Status |
| --- | --- | --- |
| [Tailscale](https://tailscale.com/) | Install and bring up tailscale, tagged as "server" | ✅ |
| [Docker](https://www.docker.com/) | Install docker and deploy portainer and nautical-backup for container volumes | ✅ |
| [PiHole](https://pi-hole.net/) | Install and configure PiHole and Gravity Sync | ❌ |
#### Containers
Containers deployed by this playbook
| Container | Status |
| --- | --- |
| [VS Code Server](https://code.visualstudio.com/docs/remote/vscode-server) | ✅ |
| [Gitea](https://about.gitea.com/) | ✅ |
| [Jellyfin](https://jellyfin.org/) | ✅ |
| [Ntfy](https://ntfy.sh) | ✅ |
| [Paperless-NGX](https://docs.paperless-ngx.com/) | ✅ |
| [Plex](https://plex.tv) | ✅ |
| [Uptime Kuma](https://uptime.kuma.pet/) | ✅ |
| [Vikunja](https://vikunja.io/) | ✅ |

