# A Collection of Ansible Playbooks for my Homelab
## Usage
First, cd into the directory where you cloned the repo. Then, create a hosts.ini file

```
nano hosts.ini
```

An example hosts file is below. Add any hosts that you want docker installed on to a group called 'docker'

```
[servers]
192.168.0.100
192.168.0.101

[docker]
192.168.0.100
```

The command to run initial setup for ubuntu servers is:

```
nsible-playbook -i hosts.ini ./ubuntusetup/playbook.yml -u <username> --become --ask-vault-pass
```

To install docker on all desired machines, run:

```
ansible-playbook -i hosts.ini docker.yml -u <username> --become
```

## Recent additions

Recently added support in the ubuntusetup playbook for install/configuring of tailscale using the [artis3n.tailscale](https://galaxy.ansible.com/ui/standalone/roles/artis3n/tailscale/) module. <br>

Authentication to tailscale requires an [OAuth client](https://tailscale.com/kb/1215/oauth-clients) key to be created in the tailscale admin console. Optionally, you can also use a tailscale auth key, however these have a maximum lifetime of 90 days. <br>

Creating an OAuth key requires creating an [ACL tag](https://tailscale.com/kb/1068/acl-tags?q=acl%20tags) in your tailscale access controls file. I simply uncommented the default from:<br>

```	
// Define the tags which can be applied to devices and by which users.
	//"tagOwners": {
	//  	"tag:example":["autogroup:admin"],
	// },
```
to:<br>
```
// Define the tags which can be applied to devices and by which users.
	"tagOwners": {
	  	"tag:servers":["autogroup:admin"],
	 },
```
You can call the tag anything you want. You just have to tag the OAuth key with *something*.

Once created, make note of the secret. We'll store it in an encrypted ansible vault file with the command:<br>

```
ansible-vault create --vault-id tailscale_oauth_key@prompt tailscale_oauth_key.yml
```
**tailscale_oauth_key** is the name of the ansible vault-id and **tailscale_oauth_key.yml** is the name of the encrypted file. They do not have to be the same. 

I discovered in testing that the variable containing your authkey must be in dictionary/hash format. Using the templates provided should avoid any issues with this. 