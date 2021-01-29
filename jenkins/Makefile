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

install-LINUX: install-LINUX-$(OSID)

install-LINUX-ubuntu: install-LINUX-debian

# @see https://pkg.jenkins.io/debian-stable/
# TODO: 1. Install Installation Manager Tool CLI
# TODO: 2. Run the installed above to sync modules
install-LINUX-debian:
	sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
	echo "deb https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list
	sudo apt-get update
	sudo apt-get install jenkins -y

	@echo "Admin Password is:"
	@cat /var/lib/jenkins/secrets/initialAdminPassword

install-OSX:

install-WINDOWS:


install-langs: install-langs-go install-langs-nodejs

install-langs-go:
	sudo -u jenkins make --directory=../lang golang

install-langs-nodejs:
	sudo -u jenkins make --directory=../lang node-nvm
	sudo -u jenkins bash -c "source ~./profile; for v in 11 12 13 14 15; do nvm install $v; done"
