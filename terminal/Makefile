## v0.2
#
# Detect OS
#
OSFLAG :=
OSARCH :=
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
else ifeq ($(SHELL),C:/Program Files/conemu/usr/bin/sh.exe)
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

conemu: conemu-$(OSFLAG) ## Install conemu

conemu-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

conemu-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

conemu-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://download.fosshub.com/Protected/expiretime=1564737346;badurl=aHR0cHM6Ly93d3cuZm9zc2h1Yi5jb20vQ29uRW11Lmh0bWw=/cc407ff6eb89618cbdb63f8bb0dc7d991a47a0322e073683541f39753ffba2db/5b85860af9ee5a5c3e979f45/5d2b89f7ac7f050a7d238675/ConEmuSetup.190714.exe" FILE="~/tmp/conemu.exe"


cmder: cmder-$(OSFLAG) ## Install cmder

cmder-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

cmder-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

cmder-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://github.com/cmderdev/cmder/releases/download/v1.3.11/cmder.zip" FILE="~/bin/cmder.zip"
	$(POWERSHELL) -Command "Expand-Archive ~/bin/cmder.zip -DestinationPath ~/bin/cmder"
	make --directory=$(DIR_INSTALL) rm FILE="~/bin/cmder.zip"


iterm: iterm-$(OSFLAG) ## Install iterm

iterm-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

iterm-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

iterm-WIN32:
	@echo $(NOT_IMPLEMENTED_WINDOWS)


hyper: hyper-$(OSFLAG) ## Install hyper

hyper-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

hyper-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

hyper-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://releases.hyper.is/download/win" FILE="~/tmp/hyper.exe"