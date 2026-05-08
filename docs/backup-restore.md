# Backup and Restore

## Backup
Run backup playbook:
```bash
./scripts/backup.sh
```

Backups are stored in `gitlab_backup_path` (default `/var/opt/gitlab/backups`).

## Restore warning
Restore operations are destructive and can overwrite current GitLab data. Plan downtime and validate backup IDs before proceeding.

## Guarded restore playbook
`playbooks/restore-gitlab.yml` does not run restore automatically. It requires:
- `confirm_restore=true`
- `gitlab_restore_backup_id=<BACKUP_ID>`

Example guarded invocation:
```bash
ansible-playbook -i inventory/hosts.ini playbooks/restore-gitlab.yml -e confirm_restore=true -e gitlab_restore_backup_id=1712345678_2026_05_08_16.0.1
```

The playbook prints a manual restore command and directs you to complete restore steps explicitly.
