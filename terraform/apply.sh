#!/bin/sh
set -e

# first, run terraform
# (terraform has to save the state file before we can invoke ansible)
terraform apply

# little pause to allow the box to come up properly
sleep 10

# provision
sh ansible.sh
