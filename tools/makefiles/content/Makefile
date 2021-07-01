## ---
## CONTENT CLEANUP
## ---

cleanup-folders: ## Removes all dynamically generated folders. WARNING: Permanent deletion!
	@echo "$(COLOR_GREEN)\n--- Removing dynamically generated branch folders.$(COLOR_END)"
	@rm -Rf terraform/$(BRANCH)
	@rm -Rf ansible/inventory/$(BRANCH)
	@rm -Rf ansible/files/$(BRANCH)

cleanup-kubeconfig: ## Removes all dynamically generated kubeconfig files from the Ansible folder. WARNING: Permanent deletion!
	@echo "$(COLOR_GREEN)\n--- Removing dynamically generated Kubeconfig file.$(COLOR_END)"
	@rm -Rf ansible/files/kubeconfig/abops-*


## -----
## CONTENT GENERATION
## ----

generate-folder: ## Generates the development folder.
	@echo "$(COLOR_GREEN)\n--- Dynamically generating Terraform folders based on $(BRANCH) name.$(COLOR_END)"
	@test -d terraform/$(BRANCH) || cp -Rf terraform/do_default terraform/$(BRANCH)

generate-secrets-yaml: ## Generate the variables.yml file if it doesn't exist.
	@echo "$(COLOR_GREEN)\n--- Generating secrets.yml file if it does not already exist.$(COLOR_END)"
	@test -s secrets.yml || cp secrets.yml.dist secrets.yml



## ---
## CONTENT UPDATES
## ---

populate-kubeconfig-ip: ## Updates the kubeconfig file with the IP address of a master node in the cluster.
	@echo "$(COLOR_GREEN)\n--- Populating the $(KUBECONFIG) file with the external public IP address.$(COLOR_END)"
	@chmod +x tools/updateKubeconfig.py
	@python3 tools/updateKubeconfig.py

populate-vars: ## Populate the vars
	@echo "$(COLOR_GREEN)\n--- Dynamically populating the Terraform variables files.$(COLOR_END)"
	@chmod +x tools/dynamicVariables.py 
	@chmod +x tools/populateProvider.py
	@python3 tools/dynamicVariables.py
	@python3 tools/populateProvider.py

populate-ansible-config: ## Populate the vars
	@cd terraform/$(BRANCH) && terraform apply -target="local_file.ansible_config" -auto-approve