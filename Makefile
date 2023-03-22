include Makefile.include

## Add your make instructions here

PY = python
PIP = pip

ifneq (,$(wildcard ./Makefile.py-version.include))
include Makefile.py-version.include
endif

PIP_FLAGS=--trusted-host pypi.org --trusted-host pypi.python.org
PIP_INSTALL=$(PIP) install $(PIP_FLAGS)

ifeq ($(OSFLAG),WIN32)
LOCAL_ENV=.\env\Scripts
else
LOCAL_ENV=./env/bin
endif
LOCAL_PY=$(LOCAL_ENV)/python
LOCAL_PIP=$(LOCAL_ENV)/pip
LOCAL_PIP_INSTALL=$(LOCAL_PIP) install $(PIP_FLAGS)
LOCAL_ANSIBLE=$(LOCAL_ENV)/ansible

AP_INVENTORY=./inventory.yml
AP_INVENTORY_SUBSET=localhost
AP_USER=dragosc

APR_NO_KEY=$(LOCAL_ANSIBLE)-playbook -i $(AP_INVENTORY) -l $(AP_INVENTORY_SUBSET) --ask-pass --ask-become-pass --user $(AP_USER)
APR_NO_INV=$(LOCAL_ANSIBLE)-playbook --private-key=.ssh/id_ed25519 --user root
APBR=$(APR_NO_INV) -i $(AP_INVENTORY) -l $(AP_INVENTORY_SUBSET)

configure: venv ## Configure your project for development (like venv but with git hooks)

CLEAN_FULL=
clean: ## Clean all dist/temp folders
	rm -rf env

INSTRUMENTATION_TERRAFORM=1
TERRAFORM_VERSION=1.4.2
instrumentation: ## Install instrumentation tools
ifeq ($(INSTRUMENTATION_TERRAFORM),1)
	$(APBR) ./playbooks/instrumentation/terraform.yml -e "terraform_version=${TERRAFORM_VERSION}"
endif

# # setup-initial: ssh-keysync ## Install generic tools on all servers
# setup-initial: ## Install generic tools on all servers
# 	# $(APR_NO_INV) -i ./inventory_temp.yml ./playbooks/netplan.yml
# 	# $(APBR) ./playbooks/utils.yml
# 	# $(APBR) ./playbooks/docker.yml
# 	$(APBR) ./playbooks/myhome-monitor.yml


ssh-keygen: ## Generate a SSH key
	rm -rf ./.ssh
	mkdir -p ./.ssh
	ssh-keygen -t ed25519 -C "dragos.cirjan@gmail.com" -f ./.ssh/id_ed25519 -q -N ""

ssh-keysync: ssh-keygen ## Generate & Synchronze SSH Keys to the affected hosts
	$(APR_NO_KEY) $(ANSIBLE_OPTIONS) ./playbooks/ssh-key.yml


VIRTUALENV_ARGS =
venv: venv-clean virtualenv ## Create a Virtual Environment
	$(PY) -m virtualenv $(VIRTUALENV_ARGS) --prompt '|> $(PROJECT) <| ' env
	$(LOCAL_PIP) install -r requirements-dev.txt
	$(LOCAL_PY) -m pip install --upgrade pip

	@echo =====================================================================
	@echo = VirtualENV Setup Complete. Now run: source env/bin/activate       =
	@echo =====================================================================


venv-clean:
	rm -rf ./env


virtualenv:
	$(PIP_INSTALL) virtualenv
