include ../Makefile.template

#
# ENV
#

DIR_INSTALL = ../.install

MAKE_LANG = make --directory=../lang

RUN_AS_JENKINS = sudo -u jenkins

JENKINS_MAKE_LANG = $(RUN_AS_JENKINS) $(MAKE_LANG)
JENKINS_SUDO_MAKE_LANG = $(RUN_AS_JENKINS) sudo $(MAKE_LANG)

JENKINS_EMAIL = dragos.cirjan+jenkins@gmail.com

#
# Actual Action Definitions
#

pre-install:
	$(MK) --directory=$(DIR_INSTALL) essential

# @see https://www.jenkins.io/projects/gsoc/2019/plugin-installation-manager-tool-cli/
# Use to sync plugins between Jenkins instances
install: pre-install install-$(OSFLAG) ## Install Jenkins

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

	sudo cat /etc/sudoers | grep jenkins || sudo echo "jenkins     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

	which ssh-keygen && $(RUN_AS_JENKINS) bash -c 'ssh-keygen -t ed25519 -b 4096 -C "$(JENKINS_EMAIL)" -f "$$HOME/.ssh/id_ed25519" -P ""'

install-OSX:

install-WIN32: req_root
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.jenkins.io/download/thank-you-downloading-windows-installer-stable/" PACKAGE_MATCH="jenkins.msi" PACKAGE_ARGS="/norestart"


install-langs: install-langs-$(OSFLAG) ## Install Langs 4 Jenkins

install-langs-LINUX:
	$(SMK) install-langs--go
	$(SMK) install-langs--nodejs
	$(SMK) install-langs--python

install-langs--go: install-langs--go-$(OSFLAG)  ## Install Go 4 Jenkins

install-langs--go-LINUX: req_root
	$(JENKINS_MAKE_LANG) golang GO_VERSION=1.15
	for ver in 1.12 1.13 1.14; do \
		$(JENKINS_MAKE_LANG) golang-add GO_VERSION=$$ver; \
		done


install-langs--nodejs: install-langs--nodejs-$(OSFLAG) ## Install NodeJs(NVM) 4 Jenkins

install-langs--nodejs-LINUX: req_root
	$(JENKINS_MAKE_LANG) nodejs-nvm
	for ver in 11 13 14 15; do \
		$(JENKINS_MAKE_LANG) nodejs-nvm-add NODE_VERSION=$$ver; \
		done


install-langs--python: install-langs--python-$(OSFLAG) ## Install Python 4 Jenkins

install-langs--python-LINUX: req_root
	for ver in 3.5 3.6 3.7 3.8 3.9; do \
		$(JENKINS_SUDO_MAKE_LANG) python PY_VERSION=$$ver; \
		done

install-sonar: install-sonar-$(OSFLAG)

install-sonar-MACOS:
	echo ""

install-sonar-LINUX:
	echo ""

install-sonar-WINDOWS:
	echo ""
