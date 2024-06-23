#!/bin/bash

# Prompt for the become password
read -sp 'BECOME password: ' BECOME_PASS
echo  # Add a newline for better formatting

# Prompt for the vault password
read -sp 'VAULT password: ' VAULT_PASS
echo  # Add a newline for better formatting

# Run the ansible-playbook command with the passwords passed as extra vars
ANSIBLE_BECOME_PASS="$BECOME_PASS" ANSIBLE_VAULT_PASS="$VAULT_PASS" \
ansible-playbook -i hosts.ini baseline/proxmox/main.yml --extra-vars "ansible_become_pass=$BECOME_PASS ansible_vault_password=$VAULT_PASS"
ansible-playbook -i hosts.ini main.yml --extra-vars "ansible_become_pass=$BECOME_PASS ansible_vault_password=$VAULT_PASS"
