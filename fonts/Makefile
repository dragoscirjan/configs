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
else ifeq ($(SHELL),/bin/sh)
	SHELL_IS = bash
else
    SHELL_IS = powershell
endif

#
# Help Directive
#
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.DEFAULT_GOAL := help

#
# Actual Action Definitions
#

firacode: ## Install Fira Code Font https://github.com/tonsky/FiraCode
	@echo 'Installing Source Code Pro Font'
ifeq ($(SHELL_IS),bash)
else
	powershell -File ..\\windows\\install-font.ps1 -url "https://github.com/tonsky/FiraCode/releases/download/1.206/FiraCode_1.206.zip" -isFile "false"
endif

sourcecodepro: ## Install Source Code Pro Font https://github.com/adobe-fonts/source-code-pro
	@echo 'Installing Source Code Pro Font'
ifeq ($(SHELL_IS),bash)
else
	powershell -File ..\\windows\\install-font.ps1 -url "https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Italic.ttf" -isFile "true"
	powershell -File ..\\windows\\install-font.ps1 -url "https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Roman.ttf" -isFile "true"
endif

all: firacode sourcecodepro ## Install all Fonts