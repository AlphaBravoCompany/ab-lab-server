## -----
## CONTENT GENERATION
## ----

generate-folder-aws: ## Generates the development folder.
	@echo "$(COLOR_GREEN)\n--- Dynamically generating Terraform folders based on $(BRANCH) name.$(COLOR_END)"
	@test -d terraform/$(BRANCH) || cp -Rf terraform/aws_spot_default terraform/$(BRANCH)