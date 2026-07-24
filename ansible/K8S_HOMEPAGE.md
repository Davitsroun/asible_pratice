# Kubernetes (k3s) + Homepage — Ansible lab

## What you get

| Node | Role | IP |
|------|------|----|
| tnode1 | k3s **server** (control plane) | 10.10.1.11 |
| tnode2 | k3s **agent** (worker) | 10.10.1.12 |
| tnode3 | k3s **agent** (worker) | 10.10.1.13 |

Then **[Homepage](https://gethomepage.dev/)** is installed with Helm (NodePort `30080`).

## Playbooks

```text
install_k8s.yml        # install k3s + join 3 nodes
install_homepage.yml   # deploy Homepage on the cluster
```

## Run (from ansible-server)

```bash
cd ~/my-ansible

# 1) Rebuild privileged nodes (needed for k3s), then SSH keys
# On Windows host:
#   docker compose up -d --build
#   docker exec -it ansible-server bash
./setup-ssh.sh   # or week1/setup-ssh.sh if you moved it

# 2) Install cluster
ansible-playbook install_k8s.yml

# 3) Install Homepage
ansible-playbook install_homepage.yml

# 4) Check
ssh tnode1 'kubectl get nodes'
ssh tnode1 'kubectl -n homepage get pods,svc'
```

Open Homepage (from a browser that can reach Docker network), e.g.:

```text
http://10.10.1.11:30080
```

Port may differ if the chart maps NodePort differently — check with `kubectl -n homepage get svc`.

## Important notes

1. **k3s needs privileged containers** — `docker-compose.yml` sets `privileged: true`.
2. Your old SSH-only Ubuntu containers are **minimal**; after compose recreate, re-run `setup-ssh.sh`.
3. On some Docker Desktop / WSL setups, nested k3s can still fail (cgroup/kernel). If that happens, use real Ubuntu VMs with the same playbooks — they work the same.
4. `krew` / full kubeadm are not used here; **k3s** is lighter for a 3-node lab.

## Files

```text
install_k8s.yml
install_homepage.yml
roles/k3s_server/
roles/k3s_agent/
roles/homepage/
inventory   # controlplane + workers groups
```
