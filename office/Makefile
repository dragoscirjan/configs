include ../Makefile.template

#
# Actual Action Definitions
#

POWERSHELL=powershell -ExecutionPolicy ByPass

DIR_INSTALL = ../.install

default: ## Install default Office App (WPS Office)
	make wpsoffice

# --------------------------------------------------------------------------------------

libreoffice: libreoffice-$(OSFLAG) ## Install Discord
libreoffice-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

libreoffice-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

libreoffice-WIN32: APP_NAME=libreoffice
libreoffice-WIN32: app-WIN32

notion: APP_NAME=notion
notion: BREW_ARGS=--cask
notion: app-$(OSFLAG) ## Install Notion

wpsoffice: wpsoffice-$(OSFLAG) ## Install WPS Office
wpsoffice-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

wpsoffice-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

wpsoffice-WIN32: APP_NAME=wps-office-free
wpsoffice-WIN32: app-WIN32
