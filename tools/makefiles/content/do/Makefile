## -----
## CONTENT GENERATION
## ----

generate-folder-do: ## Generates the development folder.
	@echo "$(COLOR_GREEN)\n--- Dynamically generating Terraform folders based on $(BRANCH) name.$(COLOR_END)"
	@test -d terraform/$(BRANCH) || cp -Rf terraform/do_default terraform/$(BRANCH)