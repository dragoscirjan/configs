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
	$(POWERSHELL) -File ./install.ps1 -Url "$(PACKAGE_URL)" -File "$(PACKAGE_FILE)" -FileMatch "$(PACKAGE_MATCH)" -ArgumentList "$(PACKAGE_ARGS)"

essential: essential-$(OSFLAG) ## Install Essential Stuff

essential-LINUX: req_root essential-LINUX-$(OSID)

essential-LINUX-ubuntu: essential-LINUX-debian
essential-LINUX-debian:
	apt-get update
	which curl || sudo apt-get install -y curl
	which git || sudo apt-get install -y git
	which git || sudo apt-get install -y jq
	which vim || sudo apt-get install -y vim
	which make || sudo apt-get install -y make
	which gcc || sudo apt-get install -y build-essential

essential-WIN32:
	echo 'essential windows'

# #
# # echo Local Package
# #

# PACKAGE_PATH =
# il: il-$(OSFLAG) ## echo Local Package PACKAGE_PATH=... PACKAGE_ARGS=...

# il-WIN32:
# 	$(POWERSHELL) -File ./echo.ps1 --File "$(PACKAGE_PATH)" --ArgumentList "$(PACKAGE_ARGS)"


