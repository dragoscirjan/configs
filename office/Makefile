## v0.4
#
# Detect OS
#
OSFLAG :=
OSARCH :=
OSID :=
ifeq ($(OS),Windows_NT)
	OSFLAG = WIN32
	ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
		OSARCH = AMD64
	endif
	ifeq ($(PROCESSOR_ARCHITECTURE),x86)
		OSARCH = IA32
	endif
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		OSFLAG = LINUX
		OSID = $(shell cat /etc/*-release | egrep "^ID=" | cut -f2 -d=)
	endif
	ifeq ($(UNAME_S),Darwin)
		OSFLAG = OSX
	endif
		UNAME_P := $(shell uname -p)
	ifeq ($(UNAME_P),x86_64)
		OSARCH = AMD64
	endif
		ifneq ($(filter %86,$(UNAME_P)),)
			OSARCH = IA32
		endif
	ifneq ($(filter arm%,$(UNAME_P)),)
		OSARCH = ARM
	endif
endif

#
# Detect Shell
#
SHELL_IS := 
ifeq ($(SHELL),/bin/bash)
    SHELL_IS = bash
else ifeq ($(SHELL),/usr/bin/bash)
    SHELL_IS = bash
else ifeq ($(SHELL),/bin/sh)
	SHELL_IS = bash
else ifeq ($(SHELL),C:/Program Files/Git/usr/bin/sh.exe)
	SHELL_IS = bash
else
    SHELL_IS = powershell
endif

#
# Help Directive
#
.PHONY: help
help:
ifeq ($(SHELL_IS),bash)
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
else
	@echo 'Windows Help not available yet.'
endif
.DEFAULT_GOAL := help

#
# Binaries
#

ifeq (bash,$(SHELL_IS))
	CURL=curl -SL
else
	CURL=powershell -ExecutionPolicy ByPass -File ../.ps/curl.ps1 --url
endif
POWERSHELL=powershell -ExecutionPolicy ByPass

#
# ENV
#

NOT_IMPLEMENTED_LINUX = "Not implemented under Linux"
NOT_IMPLEMENTED_OSX = "Not implemented under OSX"
NOT_IMPLEMENTED_WINDOWS = "Not implemented under Windows"

POWERSHELL=powershell -ExecutionPolicy ByPass

DIR_INSTALL = ../.install

#
# Actual Action Definitions
#

libreoffice: libreoffice-$(OSFLAG) ## Install Libre Office

libreoffice-LINUX:
	make --directory=$(DIR_INSTALL) i PACKAGE=libreoffice

libreoffice-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

libreoffice-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://mirror.dkm.cz/tdf/libreoffice/stable/6.2.5/win/x86_64/LibreOffice_6.2.5_Win_x64.msi" FILE="~/tmp/libre-office.msi"


wpsoffice: wpsoffice-$(OSFLAG) ## Install WPS Office

# http://wps-community.org/downloads
wpsoffice-LINUX: wpsoffice-$(OSID)

wpsoffice-ubuntu: wpsoffice-debian

wpsoffice-debian:
	make --directory=$(DIR_INSTALL) iu URL="http://kdl.cc.ksosoft.com/wps-community/download/8722/wps-office_11.1.0.8722_amd64.deb" FILE="~/tmp/wps-office.deb"

# wpsoffice-redhat:
# 	make --directory=$(DIR_INSTALL) iu URL="http://kdl.cc.ksosoft.com/wps-community/download/8722/wps-office-11.1.0.8722-1.x86_64.rpm" FILE="~/tmp/wps-office.rpm"

wpsoffice-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

wpsoffice-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="http://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/11.2.0.8684/WPSOffice_11.2.0.8684_Free.exe" FILE="~/tmp/wps-office.exe"