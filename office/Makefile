include ../Makefile.template

#
# Actual Action Definitions
#

POWERSHELL=powershell -ExecutionPolicy ByPass

DIR_INSTALL = ../.install

default: ## Install default Office App (WPS Office)
	make wpsoffice

APP_NAME=
app-LINUX:
	snap install $(APP_NAME)

app-OSX:
	brew install $(APP_NAME)

app-WIN32:
	choco upgrade -y $(APP_NAME)

# --------------------------------------------------------------------------------------


libreoffice: libreoffice-$(OSFLAG) ## Install Discord
libreoffice-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

libreoffice-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

libreoffice-WIN32: APP_NAME=libreoffice
libreoffice-WIN32: app-WIN32


wpsoffice: wpsoffice-$(OSFLAG) ## Install Ferdium
wpsoffice-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

wpsoffice-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

wpsoffice-WIN32: APP_NAME=wps-office-free
wpsoffice-WIN32: app-WIN32