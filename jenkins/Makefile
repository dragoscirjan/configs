include ../Makefile.template

#
# ENV
#

DIR_INSTALL = ../.install

#
# Actual Action Definitions
#

# @see https://www.jenkins.io/projects/gsoc/2019/plugin-installation-manager-tool-cli/
# Use to sync plugins between Jenkins instances
install: install-$(OSFLAG) ## Install Jenkins

install-LINUX: req_root install-LINUX-$(OSID)

install-LINUX-ubuntu: install-LINUX-debian

# @see https://pkg.jenkins.io/debian-stable/
# TODO: 1. Install Installation Manager Tool CLI
# TODO: 2. Run the installed above to sync modules
install-LINUX-debian:
	wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
	echo "deb https://pkg.jenkins.io/debian-stable binary/" | tee /etc/apt/sources.list.d/jenkins.list
	apt-get update
	apt-get install jenkins -y

	@echo "Admin Password is:"
	@cat /var/lib/jenkins/secrets/initialAdminPassword

install-OSX:

install-WINDOWS:


install-langs: install-langs-go install-langs-nodejs install-langs-python ## Install Langs 4 Jenkins

install-langs-go: ## Install Go 4 Jenkins
	sudo make --directory=../lang golang GO_VERSION=1.15
	for ver in 1.12 1.13 1.14; do \
		sudo -u jenkins make golang-add GO_VERSION=$$ver; \
		done

install-langs-nodejs: ## Install NodeJs(NVM) 4 Jenkins
	sudo -u jenkins make --directory=../lang node-nvm
	sudo -u jenkins bash -c "source ~./profile; for v in 11 12 13 14 15; do nvm install \\$$v; done"

install-langs-python: req_root ## Install Python 4 Jenkins
	for ver in 3.5 3.6 3.7 3.8 3.9; do \
		sudo -u jenkins make --directory=../lang python PY_VERSION=$$ver; \
		done

