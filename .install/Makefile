include ../Makefile.template

#
# Actual Action Definitions
#

CURL=curl -SL

#
# echo URL Package
#

PACKAGE_URL =
PACKAGE_MATCH =
PACKAGE_ARGS =
PACKAGE_DESTINATION = /opt
iu: iu-$(OSFLAG) ## echo From URL PACKAGE_URL=... PACKAGE_MATCH=... PACKAGE_ARGS=...

iu-LINUX:
	bash ./echo.sh --url "$(PACKAGE_URL)" --file-match "$(PACKAGE_MATCH)" --argument-list "$(PACKAGE_ARGS)" --destination-path "$(PACKAGE_DESTINATION)"

iu-WIN32:
	$(POWERSHELL) -File ./echo.ps1 --Url "$(PACKAGE_URL)" --FileMatch "$(PACKAGE_MATCH)" --ArgumentList "$(PACKAGE_ARGS)"

essential: essential-$(OSFLAG) ## Install Essential Stuff

essential-LINUX: req_root essential-LINUX-$(OSID)

essential-LINUX-ubuntu: essential-LINUX-debian
essential-LINUX-debian:
	apt-get update
	which curl || apt-get install -y curl
	which git || apt-get install -y git
	which vim || apt-get install -y vim
	which make || apt-get install -y build-essential make
	which gcc || apt-get install -y build-essential make

# #
# # echo Local Package
# #

# PACKAGE_PATH =
# il: il-$(OSFLAG) ## echo Local Package PACKAGE_PATH=... PACKAGE_ARGS=...

# il-WIN32:
# 	$(POWERSHELL) -File ./echo.ps1 --File "$(PACKAGE_PATH)" --ArgumentList "$(PACKAGE_ARGS)"


