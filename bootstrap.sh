#!/bin/bash

. /vagrant/env.sh

printf "${G}*** Running updates ***${N}\n"
#apt update && apt upgrade -y && apt autoremove -y
apt install curl
sudo systemctl stop ufw
sudo systemctl disable ufw
