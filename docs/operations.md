# Operations

## Ansible helper commands
```bash
./scripts/ping.sh
./scripts/deploy.sh
./scripts/validate.sh
./scripts/backup.sh
```

## Direct operational commands on target VM
```bash
sudo gitlab-ctl status
sudo gitlab-ctl reconfigure
sudo gitlab-ctl restart
sudo gitlab-ctl tail
```

## Check listening ports
```bash
sudo ss -ltnp | grep -E ':22|:80|:443'
```

## Check configured external_url
```bash
grep -F "external_url" /etc/gitlab/gitlab.rb
```
