include ../../../Makefile.template

#
# Actual Action Definitions
#

install: ## Install Requirements
	cd ../docker && make install
	which netstat || \
	$(PACKAGE_INSTALL) net-tools

run: ## Run Pi-Hole
	bash ./init.sh
