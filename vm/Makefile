include ../Makefile.template

# --------------------------------------------------------------------------------------

default: ## Install default VM tools (Virtualbox)
	make vagrant
	make virtualbox

vagrant: ## Install git (https://www.virtualbox.org/)
	make app-$(OSFLAG) APP_NAME=vagrant

virtualbox: ## Install git (https://www.virtualbox.org/)
	make app-$(OSFLAG) APP_NAME=virtualbox

