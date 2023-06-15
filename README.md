# 1. Install k8s cluster
- `install.sh` will run all following steps.

## 1.1. Setup hostname on every VMs
- `hostnamectl set-hostname <hostname>`
## 1.2. Edit file ./hosts
- Make sure inventory_name=\<hostname\> and ansible_host=\<IP\>.
## 1.3. Prepare all VMs.
- `ansible-playbook -i hosts 1-prepare-vm.yml`
- ` showmount -e <master IP>` to verify if nfs server is up.
## 1.4. Setup master.
- `ansible-playbook -i hosts 2-setup-master.yml`
- `crictl images` to verify installation.
- `kubectl get nodes -o wide` to verify the master node is up and ready.
## 1.5. Setup workders.
- `ansible-playbook -i hosts 3-setup-workers.yml`
- `kubectl get nodes -o wide` to verify all worker nodes are up and ready.
## 1.6. Setup helm and install all k8s plugins.
- `ansible-playbook -i hosts 4-setup-helm-master.yml`
- `helm list -A` to check if the plugins are deployed.
- `kubectl get pods -A` to check the plugins are running.

# 2. Setup dashboard

### 2.1. Setup DNS or local /etc/hosts file to resovling hostname k8HostName
### 2.2. Apply ingress service.
- `ansible-playbook -i hosts 5-apply-ingress-service.yml`
- `kubectl get services -n kube-system` or `kubectl get services -A` to check all running services.
- Access https://\<k8HostName\> to check service status.

# 3. Setup login token
## 3.1. Create Token
- `ansible-playbook -i hosts 6-setup-token.yml`
- Get token from output, use it on GUI to login


