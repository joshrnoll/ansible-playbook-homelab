#!/bin/bash

# Install requirements
# echo "Installing requirements..."
# pip install -r requirements.txt

##################################
# PROMPT FOR THE BECOME PASSWORD #
##################################
read -sp 'BECOME password: ' BECOME_PASS
echo  

#################################
# PROMPT FOR THE VAULT PASSWORD #
#################################
read -sp 'VAULT password: ' VAULT_PASS
echo  

##################################################
# CREATE A TEMPORARY FILE FOR THE VAULT PASSWORD #
##################################################
VAULT_PASS_FILE=$(mktemp)
echo "$VAULT_PASS" > "$VAULT_PASS_FILE"

###############################################################
# ENSURE THE TEMPORARY FILE IS DELETED AFTER SCRIPT EXECUTION #
###############################################################
trap 'rm -f "$VAULT_PASS_FILE"' EXIT

#######################################################################
# CALL PLAYBOOK FOR PROXMOX SETUP AND CLOUD-INIT VM TEMPLATE CREATION #
#######################################################################
ansible-playbook -i hosts.yml baseline/proxmox/main.yml \
--extra-vars "ansible_become_pass=$BECOME_PASS root_playbook_dir=$PWD" \
--vault-password-file "$VAULT_PASS_FILE"

###########################################
# CALL MAIN.YML FOR HOMELAB CONFIGURATION #
###########################################
ansible-playbook -i hosts.yml main.yml \
--extra-vars "ansible_become_pass=$BECOME_PASS root_playbook_dir=$PWD" \
--vault-password-file "$VAULT_PASS_FILE"