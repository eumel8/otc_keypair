#!/bin/sh

echo "PRE TASK - generate ssh key pair"
ssh-keygen -q -N '' -f travis_key
echo "SCENARIO 1: create admin key"
ansible-playbook test.yml -e "ecs_adminkey=ansible-key02 keypair_file=travis_key.pub localaction=create" || exit 1
echo "SCENARIO 2: show admin key"
ansible-playbook test.yml -e "ecs_adminkey=ansible-key02 localaction=show" || exit 1
echo "SCENARIO 3: list admin keys"
ansible-playbook test.yml -e "localaction=list" || exit 1
echo "SCENARIO 4: delete admin key"
ansible-playbook test.yml -e "ecs_adminkey=ansible-key02 keypair_file=travis_key.pub localaction=delete" || exit 1
echo "POST TASK - remove generated keys"
rm -rf travis_key*
