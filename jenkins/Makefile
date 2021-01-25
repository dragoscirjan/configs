include ../Makefile.template

#
# ENV
#

DIR_INSTALL = ../.install

#
# Actual Action Definitions
#

install: install-$(OSFLAG) ## Install Jenkins

install-LINUX: install-LINUX-$(OSID)

install-LINUX-ubuntu: install-LINUX-debian

# see https://pkg.jenkins.io/debian-stable/
install-LINUX-debian:
	sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
	echo "deb https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list
	sudo apt-get update
	sudo apt-get install jenkins -y
