# ansible-gitlab-ce-deploy

## Project overview
This repository provides a clean Ansible-based bootstrap workflow to install and operate GitLab CE (Omnibus package) on a single Ubuntu VM for lab and portfolio use.

## What problem this solves
It gives a repeatable way to:
- Install GitLab CE with standard prerequisites.
- Apply configuration from version-controlled variables and template.
- Validate service health and basic endpoint availability.
- Run backups with documented restore safety guardrails.

## Scope
- Single-node GitLab CE on Ubuntu 22.04/24.04.
- Ansible control machine connects over SSH.
- Day-0/Day-1 lab operations: install, configure, validate, backup.

## What this project intentionally does not do
- Not production HA.
- Does not provision cloud or VM infrastructure.
- Does not install GitLab Runner.
- Does not use Kubernetes or Helm.

## Architecture flow
1. Control machine runs playbooks against `gitlab` inventory group.
2. Role installs prerequisites and GitLab CE package.
3. Role renders `/etc/gitlab/gitlab.rb` from template.
4. Handler runs `gitlab-ctl reconfigure` and restart when config changes.
5. Validation tasks check status, ports, local HTTP, and backup path.

See `docs/architecture.md` for details.

## Repository structure
- `ansible.cfg` - local Ansible behavior defaults.
- `requirements.yml` - dependencies file.
- `inventory/hosts.example.ini` - sample host inventory.
- `inventory/group_vars/gitlab.yml` - lab-safe defaults.
- `playbooks/` - install, configure, validate, backup, guarded restore.
- `roles/gitlab_ce/` - reusable role implementation.
- `scripts/` - helper shell wrappers.
- `docs/` - architecture, operations, backup/restore, troubleshooting, security.
- `.github/workflows/ansible-lint.yml` - lint and syntax checks.

## Prerequisites
- Ansible installed on control machine.
- SSH access from control machine to Ubuntu target VM.
- Sudo permissions on target host.
- DNS/hosts resolution for the selected external URL.

## Inventory setup
1. Copy example inventory:
   ```bash
   cp inventory/hosts.example.ini inventory/hosts.ini
   ```
2. Edit `inventory/hosts.ini` with your target host details.

## Variable configuration
- Default role values: `roles/gitlab_ce/defaults/main.yml`.
- Recommended overrides: `inventory/group_vars/gitlab.yml`.
- Adjust `gitlab_external_url`, ports, and backup settings as needed.

## Quick start
```bash
./scripts/ping.sh
./scripts/deploy.sh
./scripts/validate.sh
./scripts/backup.sh
```

## Deploy command
```bash
./scripts/deploy.sh
```

## Validate command
```bash
./scripts/validate.sh
```

## Backup command
```bash
./scripts/backup.sh
```

## Restore safety note
`playbooks/restore-gitlab.yml` is intentionally guarded and does not execute a destructive restore automatically. You must explicitly set `confirm_restore=true` and provide `gitlab_restore_backup_id` to print guided manual steps.

## Security notes
Read `docs/security-notes.md` before real usage. Always protect secrets, restrict SSH, prefer HTTPS outside a lab, and secure backup data.
