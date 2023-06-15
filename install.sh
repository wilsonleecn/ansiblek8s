#!/bin/bash

echo "Prepare all VMs"
ansible-playbook -i hosts 1-prepare-vm.yml
echo "Setup master node"
ansible-playbook -i hosts 2-setup-master.yml
echo "Setup worker nodes"
ansible-playbook -i hosts 3-setup-workers.yml
echo "Setup helm and install k8s plugins"
ansible-playbook -i hosts 4-setup-helm-master.yml
echo "setup ingress service"
ansible-playbook -i hosts 5-apply-ingress-service.yml
echo "setup login token"
ansible-playbook -i hosts 6-setup-token.yml
