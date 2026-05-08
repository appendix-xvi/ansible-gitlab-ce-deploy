#!/usr/bin/env bash
set -euo pipefail

INVENTORY="${INVENTORY:-inventory/hosts.example.ini}"

ansible-playbook -i "${INVENTORY}" playbooks/backup-gitlab.yml
