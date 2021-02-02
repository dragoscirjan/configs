include ../Makefile.template

#
# ENV
#

DIR_INSTALL = ../.install

MAKE_LANG = make --directory=../lang

RUN_AS_JENKINS = sudo -u jenkins

JENKINS_MAKE_LANG = $(RUN_AS_JENKINS) $(MAKE_LANG)
JENKINS_SUDO_MAKE_LANG = $(RUN_AS_JENKINS) sudo $(MAKE_LANG)

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
	java -version | grep "11." || apt-get install -y openjdk-11-jdk openjdk-11-jre
	apt-get install jenkins -y

	@echo "Admin Password is:"
	@cat /var/lib/jenkins/secrets/initialAdminPassword

	sudo cat /etc/sudoers | grep jenkins || sudo echo "username     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

install-OSX:

install-WINDOWS:


install-langs: install-langs-go install-langs-nodejs install-langs-python ## Install Langs 4 Jenkins

install-langs-go: req_root ## Install Go 4 Jenkins
	$(JENKINS_MAKE_LANG) golang GO_VERSION=1.15
	for ver in 1.12 1.13 1.14; do \
		$(JENKINS_MAKE_LANG) golang-add GO_VERSION=$$ver; \
		done

install-langs-nodejs: req_root ## Install NodeJs(NVM) 4 Jenkins
	$(JENKINS_MAKE_LANG) nodejs-nvm
	for ver in 11 13 14 15; do \
		$(JENKINS_MAKE_LANG) nodejs-nvm-add NODE_VERSION=$$ver; \
		done

install-langs-python: req_root ## Install Python 4 Jenkins
	for ver in 3.5 3.6 3.7 3.8 3.9; do \
		$(JENKINS_SUDO_MAKE_LANG) python PY_VERSION=$$ver; \
		done

