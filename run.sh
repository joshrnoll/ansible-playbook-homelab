#!/bin/bash

# Prompt for the become password
read -sp 'BECOME password: ' BECOME_PASS

# new line for formatting
echo  

# Prompt for the vault password
read -sp 'VAULT password: ' VAULT_PASS

# new line for formatting
echo  

# Create a temporary file for the vault password
VAULT_PASS_FILE=$(mktemp)
echo "$VAULT_PASS" > "$VAULT_PASS_FILE"

# Ensure the temporary file is deleted after script execution
trap 'rm -f "$VAULT_PASS_FILE"' EXIT

# Call playbook for Proxmox setup and VM creation
ansible-playbook -i production.yml baseline/proxmox/main.yml \
--extra-vars "ansible_become_pass=$BECOME_PASS vars_dir_path=$PWD" \
--vault-password-file "$VAULT_PASS_FILE"

# Call main.yml for homelab configuration
ansible-playbook -i production.yml main.yml \
--extra-vars "ansible_become_pass=$BECOME_PASS vars_dir_path=$PWD" \
--vault-password-file "$VAULT_PASS_FILE"