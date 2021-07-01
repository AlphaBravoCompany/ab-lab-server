## ---
## DEPLOYMENT CONTENT
## ---

ansible-deploy: ## Run the Ansible playbook against the K8s infrastructure.
	@echo "$(COLOR_GREEN)\n--- Running Ansible Playbook.$(COLOR_END)"
#	@chmod +x tools/populateKnownHosts.py
#	@python3 tools/populateKnownHosts.py
#	@touch ansible/vault-password.txt
	@ansible-playbook -i ansible/inventory/$(BRANCH)/$(BRANCH)-inventory ansible/main.yml

ansible-bastion-deploy: ## Run the Ansible playbook against the K8s infrastructure.
	@echo "$(COLOR_GREEN)\n--- Running Ansible Playbook.$(COLOR_END)"
	@ansible-playbook -i ansible/inventory/$(BRANCH)/$(BRANCH)-inventory ansible/bastion.yml

terraform-deploy: ## Run the Terraform commands to deploy the K8s infrastructure.
	@echo "$(COLOR_GREEN)\n--- Deploying infrastructure using Terraform.$(COLOR_END)"
	@cd terraform/$(BRANCH) && terraform init && terraform validate && terraform plan && terraform apply -auto-approve

terraform-kaboom: ## Run the Terraform commands to destroy the K8s infrastructure. WARNING: Permanent deletion!
	@echo "$(COLOR_GREEN)\n--- Tearing down infrastructure deployed by Terraform.$(COLOR_END)"
	@cd terraform/$(BRANCH) && terraform destroy -auto-approve