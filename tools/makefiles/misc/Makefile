## ---
## MISC ITEMS
## ---

pause-buffer:

	@echo "$(COLOR_GREEN)\n--- Waiting $(BUFFER_ITERATIONS)0s to allow the backend infrastructure to process any unfinished work.\nPlease wait.$(COLOR_END)"

	@n=$(BUFFER_ITERATIONS); \
	while [ $${n} -gt 0 ]; do\
		echo $$n"0"; \
		n=`expr $$n - 1`; \
		sleep $(BUFFER_SLEEP); \
	done; \
	true

	@echo "$(COLOR_GREEN)\n--- Pause Buffer Complete.  Continuing.$(COLOR_END)"

## Not currently in use.
#populate-ansible-password: ## Populates the Ansible vault-password.txt file
#	@export AWS_PROFILE=ab
#	@aws secretsmanager get-secret-value --secret-id Ansible | jq -c '.SecretString' | sed 's/\\//g' | sed 's/\"{/{/g' | sed 's/}\"/}/g' | jq .ansible | sed 's/\"//g' > ansible/vault-password.txt
