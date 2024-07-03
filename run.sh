#!/bin/bash

# Prompt for the become password
read -sp 'BECOME password: ' BECOME_PASS

# new line for formatting
echo  

# Prompt for the vault password
read -sp 'VAULT password: ' VAULT_PASS

# new line for formatting
echo  

# Set password variables
ANSIBLE_BECOME_PASS="$BECOME_PASS" ANSIBLE_VAULT_PASS="$VAULT_PASS" \

# Call playbook for VM creation
ansible-playbook -i hosts.ini baseline/proxmox/main.yml --extra-vars "ansible_become_pass=$BECOME_PASS ansible_vault_password=$VAULT_PASS"

# Call main.yml for homelab configuration
ansible-playbook -i hosts.ini main.yml --extra-vars "ansible_become_pass=$BECOME_PASS ansible_vault_password=$VAULT_PASS"
