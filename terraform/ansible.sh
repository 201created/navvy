#!/bin/sh
set -e

INVENTORY=`which terraform-inventory`

# stop us having to type "yes" at unpredictable times
# (technically insecure, but I never properly check the fingerprints anyway)
JENKINS_IP=`${INVENTORY} --list | jq '.["jenkins"][0]' | sed -e 's/"//g'`
ssh -oStrictHostKeyChecking=no ubuntu@${JENKINS_IP} "sleep 1"

# run ansible
ansible-playbook -i ${INVENTORY} ../ansible/playbook.yml
