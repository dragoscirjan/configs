include ../../Makefile.template
#
# Actual Action Definitions
#

install: ## Install cURL
	which curl || \
		(which apt && sudo apt install -y curl) || \
		(which apt-get && sudo apt-get install -y curl)


uninstall: ## Uninstall cURL
	which curl && \
		(which apt && sudo apt remove --purge -y curl) || \
		(which apt-get && sudo apt-get remove --purge -y curl)

test: ## Test Docker
	curl https://google.com
