# Troubleshooting

## SSH connection failed
- Verify `ansible_host` and `ansible_user` in inventory.
- Confirm network path and SSH key permissions.
- Test with `ssh ubuntu@<target-ip>`.

## Sudo password required
- Add `-K` to prompt for become password when needed.
- Ensure the SSH user has sudo rights.

## Package install failed
- Check internet access from VM to GitLab package repository.
- Run `sudo apt update` and inspect mirror/repository errors.

## gitlab-ctl reconfigure failed
- Inspect details with `sudo gitlab-ctl tail`.
- Validate `/etc/gitlab/gitlab.rb` syntax and variables.

## external_url wrong
- Update `gitlab_external_url` in `inventory/group_vars/gitlab.yml`.
- Re-run `./scripts/deploy.sh` or `playbooks/configure-gitlab.yml`.

## Port 80 or 443 already in use
- Check conflicts: `sudo ss -ltnp | grep -E ':80|:443'`.
- Stop conflicting service or change GitLab HTTP/HTTPS settings.

## GitLab slow first startup
- Initial Omnibus reconfigure can take several minutes.
- Monitor progress with `sudo gitlab-ctl tail` and rerun validation after startup.
