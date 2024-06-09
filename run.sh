#!/bin/bash
read -sp 'Enter sudo password: ' BECOME_PASS
echo
read -sp 'Enter ansible vault password: ' VAULT_PASS
echo

# expect << EOF
#     spawn ansible-playbook -i hosts.ini baseline/proxmox/main.yml --ask-vault-pass --ask-become-pass
#     expect "BECOME password:"
#     send "$VAULT_PASS\r"
# EOF

expect << EOF
    spawn ansible-playbook -i hosts.ini main.yml --ask-vault-pass --ask-become-pass
    expect "BECOME password: "
    send "$BECOME_PASS\r"
    expect "Vault password: "
    send "$VAULT_PASS\r"
EOF