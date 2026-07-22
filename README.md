# Ansible Docker Lab (like [hackjsp week-1](https://hackjsp.tistory.com/35))

Same layout as the blog: **1 control node** + **3 managed nodes**.

| Host | Role | IP |
|------|------|----|
| ansible-server | Control node | 10.10.1.10 |
| tnode1 | Managed (web) | 10.10.1.11 |
| tnode2 | Managed (web) | 10.10.1.12 |
| tnode3 | Managed (db) | 10.10.1.13 |

## Prerequisites

- Docker Desktop running
- From this folder: `c:\cmcb_devops\ansible`

## Start the lab

```powershell
docker compose up -d --build
```

Enter the control node:

```powershell
docker exec -it ansible-server bash
```

Inside the control node, set up passwordless SSH (once):

```bash
sed -i 's/\r$//' setup-ssh.sh
chmod +x setup-ssh.sh
./setup-ssh.sh
```

## Follow the blog exercises

```bash
# Check Ansible
ansible --version

# Inventory
ansible-inventory -i ./inventory --list | jq

# Ping all managed nodes
ansible -m ping all

# Ad-hoc
ansible -m shell -a uptime all

# Playbooks
ansible-playbook --syntax-check first-playbook.yml
ansible-playbook first-playbook.yml
ansible-playbook add-hosts-playbook.yml
ansible-playbook create-user-playbook.yml
ansible-playbook facts.yml
```

## Stop / clean up

```powershell
docker compose down
# remove images too:
docker compose down --rmi local
```

Root password on managed nodes (lab only): `ansible`
