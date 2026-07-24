#!/bin/bash
set -e
sed -i 's|http://|https://|g' /etc/apt/sources.list
apt-get -o Acquire::https::Verify-Peer=false -o Acquire::https::Verify-Host=false update
apt-get -o Acquire::https::Verify-Peer=false -o Acquire::https::Verify-Host=false install -y --no-install-recommends netplan.io
mkdir -p /etc/netplan
echo "netplan ready"
