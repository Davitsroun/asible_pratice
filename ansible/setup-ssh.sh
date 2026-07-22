  #!/bin/bash
  set -euo pipefail

  NODES=(tnode1 tnode2 tnode3)

  echo "==> Waiting for managed nodes SSH..."
  for node in "${NODES[@]}"; do
    ready=0
    for i in $(seq 1 30); do
      if sshpass -p ansible ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
        root@"$node" "echo ok" >/dev/null 2>&1; then
        echo "    $node is ready"
        ready=1
        break
      fi
      sleep 1
    done
    if [ "$ready" -ne 1 ]; then
      echo "ERROR: $node SSH not ready" >&2
      exit 1
    fi
  done

  echo "==> Copying SSH public key to managed nodes..."
  for node in "${NODES[@]}"; do
    sshpass -p ansible ssh-copy-id -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
      -i /root/.ssh/id_rsa.pub root@"$node"
  done

  echo "==> Done. Test with: ansible -m ping all"
