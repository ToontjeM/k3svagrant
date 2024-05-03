#!/bin/bash

echo "--- Running bootstrap_worker.sh ---"

TOKEN=$(cat /vagrant/token)
HOSTNAME=$(hostname)

export INSTALL_K3S_EXEC="--flannel-iface=eth1"
curl -sfL https://get.k3s.io | K3S_URL=https://controlplane:6443 K3S_TOKEN=$TOKEN sh -
