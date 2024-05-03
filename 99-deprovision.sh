#!/bin/bash

. ./env.sh

printf "${R}*** De-provisioning VM's ***${N}\n"

vagrant destroy -f 