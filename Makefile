## v0.3
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

POWERSHELL=powershell -ExecutionPolicy ByPass

#
# ENV
#

NOT_IMPLEMENTED_LINUX = "Not implemented under Linux"
NOT_IMPLEMENTED_OSX = "Not implemented under OSX"
NOT_IMPLEMENTED_WINDOWS = "Not implemented under Windows"

#
# Actual Action Definitions
#

all-help: all-help-$(SHELL_IS) ## List Help on all Config Folders

all-help-bash:
	@find . -mindepth 1 -maxdepth 1 -type d | while read d; do \
		test -f $$d/Makefile \
			&& echo "$$d" \
			&& make --directory=$$d; \
	done

all-help-powershell:
	@echo 'Windows Help not available yet.'

all: ide browsers ## Install all required tools

ide: ## Install Used IDEs
	make --directory=./ide atom idea-ce pycharm-ce sublime vscode
	make --directory=./git gitkraken

browsers: ## Install Used Browsers
	make --directory=./browsers firefox edge opera vivaldi

terminal: ## Install Office Tools
	make --directory=./office libreoffice wpsoffice

terminal: ## Install Terminal Tools
	make --directory=./terminal conemu cmder iterm