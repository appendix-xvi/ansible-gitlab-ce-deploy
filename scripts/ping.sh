#!/usr/bin/env bash
set -euo pipefail

INVENTORY="${INVENTORY:-inventory/hosts.example.ini}"

ansible -i "${INVENTORY}" gitlab -m ping
