#!/bin/bash

. /vagrant/env.sh

printf "${G}*** Installing K3S on Controlplane node ***${N}\n"
export INSTALL_K3S_EXEC="--flannel-iface=eth1"
curl -sfL https://get.k3s.io | sh -

cat /var/lib/rancher/k3s/server/node-token > /vagrant/token

printf "${G}*** Generating KUBECONFIG ***${N}\n"
export KUBECONFIG=/home/vagrant/.kube/config
mkdir /home/vagrant/.kube 2> /dev/null
sudo k3s kubectl config view --raw > "$KUBECONFIG"
chmod 600 "$KUBECONFIG"
sudo chown -R vagrant:vagrant .kube

k3s kubectl get nodes -o wide