## ---
## DOCKER
## ---

docker-shell: ## Starts a shell session in the development container.
	@echo "$(COLOR_GREEN)\n--- Executing Docker shell environment.$(COLOR_END)"
	@$(DEV_EXEC) /usr/bin/zsh

docker-logs: ## Starts logging on the development container.
	@echo "$(COLOR_GREEN)\n--- Outputing Docker logs.$(COLOR_END)"
	@docker-compose logs -f $(DEV_NAME)

docker-up: ## Start internal Docker containers.
	@echo "$(COLOR_GREEN)\n--- Bringing up Docker environment.$(COLOR_END)"
	@docker-compose up -d

docker-reload: ## Reload internal Docker containers.
	@echo "$(COLOR_GREEN)\n--- Restarting Docker shell environment.$(COLOR_END)"
	@docker-compose restart

docker-down: ## Stop and remove internal Docker containers.
	@echo "$(COLOR_GREEN)\n--- Taking down Docker shell environment.$(COLOR_END)"
	@docker-compose down --remove-orphans

docker-pull: ## Pull the latest container images
	@echo "$(COLOR_GREEN)\n--- Pulling the latest Docker image.$(COLOR_END)"
	@docker pull $(REGISTRY)/abops-docker:$(REMOTE_TAG)

docker-login-gitlab: ## Login to the Gitlab registry.
	@echo "$(COLOR_GREEN)\n--- Logging into Docker registry.$(COLOR_END)"
	@docker login registry.gitlab.com

docker-system-prune: ## Remove all unused Docker images and volumes.
	@echo "$(COLOR_GREEN)\n--- Running Docker system prune.$(COLOR_END)"
	@docker system prune --force --all --volumes