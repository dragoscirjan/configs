include ../../Makefile.template
#
# Actual Action Definitions
#

install: ## Install cURL
	which curl || \
	$(PACKAGE_INSTALL) curl

uninstall: ## Uninstall cURL
	which curl && \
	$(PACKAGE_REMOVE) curl

test: ## Test Docker
	curl https://google.com
