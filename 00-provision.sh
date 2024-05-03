#!/bin/bash

. ./env.sh

printf "${G}*** De-provisioning old VM's ***${N}\n"

vagrant destroy -f

printf "${G}*** Provisioning new VM's ***${N}\n"

vagrant up --provision controlplane
vagrant up --provision worker1 &
vagrant up --provision worker2 &
vagrant up --provision worker3 &
vagrant up --provision worker4 &
