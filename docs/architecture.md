# Architecture

## Components
- **Ansible control node**: Runs playbooks and connects over SSH.
- **Target VM**: Single Ubuntu 22.04/24.04 instance in `gitlab` inventory group.
- **GitLab CE Omnibus**: Installed through official GitLab package repository.

## Configuration and converge flow
1. `playbooks/install-gitlab.yml` executes role `gitlab_ce`.
2. Role tasks install prerequisites and GitLab CE package.
3. Template `roles/gitlab_ce/templates/gitlab.rb.j2` renders `/etc/gitlab/gitlab.rb`.
4. Handler runs `gitlab-ctl reconfigure` and service restart on configuration changes.

## Validation flow
`roles/gitlab_ce/tasks/validate.yml` verifies:
- `gitlab-ctl status` output.
- `external_url` presence in `/etc/gitlab/gitlab.rb`.
- Listening ports via `ss -ltn`.
- Local HTTP response from the VM.
- Backup directory existence.
