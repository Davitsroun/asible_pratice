#!/bin/bash
set -e
cat > /etc/apt/apt.conf.d/99insecure <<'CFG'
Acquire::https::Verify-Peer "false";
Acquire::https::Verify-Host "false";
CFG
sed -i 's|http://|https://|g' /etc/apt/sources.list
apt-get update
apt-get install -y --no-install-recommends curl ca-certificates wget tar
echo DONE
