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
# Windows utils directive
#
ifeq ($(SHELL),powershell)
	Add-Type -AssemblyName System.IO.Compression.FileSystem
	function Unzip
	{
	    param([string]$zipfile, [string]$outpath)

	    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
	}
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

ifeq (LINUX,$(OSFLAG))
ifeq (debian,$(shell test -f $(which dpkg 2> /dev/null) && echo 'debian'))
	EXT=deb

	SUBLIME_URL=$(shell curl -sSL https://www.sublimetext.com | grep "Download for Mac" | awk -F'"' '{ print $$4 }')
	VSCODE_URL=https://update.code.visualstudio.com/latest/linux-deb-x64/stable
endif
ifeq (debian,$(shell test -f $(which rpm 2> /dev/null) && echo 'debian'))
	EXT=rpm

	SUBLIME_URL=$(shell curl -sSL https://www.sublimetext.com | grep "Download for Mac" | awk -F'"' '{ print $$4 }')
	VSCODE_URL=https://update.code.visualstudio.com/latest/linux-rpm-x64/stable
endif
	RM=rm -rf
	TIMESTAMP_SECCONDS=$(shell date +%s)
endif
ifeq (OSX,$(OSFLAG))
	TIMESTAMP_SECCONDS=$(shell date +%s)
	EXT=dmg

	SUBLIME_URL=$(shell curl -sSL https://www.sublimetext.com | grep "Download for Mac" | awk -F'"' '{ print $$4 }')
	VSCODE_URL=https://update.code.visualstudio.com/latest/darwin/stable
endif
ifeq (WIN32,$(OSFLAG))
	EXT=exe

	SUBLIME_URL=$(shell curl -sSL https://www.sublimetext.com | grep "Download for Mac" | awk -F'"' '{ print $$4 }')
	VSCODE_URL=https://update.code.visualstudio.com/latest/win32-x64-user/stable
	TIMESTAMP_SECCONDS=$(shell date +%s)
endif

mktmp:
ifeq (WIN32, $(OSFLAG))
	@echo 'TODO:'
else
	mkdir -p $HOME/tmp
endif


# IDEA_APP=CL # CLion
# IDEA_APP=IIC # Idea CE
# IDEA_APP=IIU # Idea
# IDEA_APP=GO # GoLand
# IDEA_APP=PS # PhpStorm
# IDEA_APP=PCC # PyCharm CE
# IDEA_APP=PCP # PyCharm
# IDEA_APP=RM # RubyMine
# IDEA_APP=WS # WebStorm
IDEA_APP=
IDEA_OS=linux
intellij: mktmp
# 	if [ "$(IDEA_APP)" == "" ]; then \	
# 	fi
	curl -sSL "https://data.services.jetbrains.com/products/releases?code=$(IDEA_APP)&latest=true&type=release&build=&_=$(TIMESTAMP_SECCONDS)" \
		| jq -r 'keys[] as $$k | .[$$k] | .[0] | .downloads.$(IDEA_OS).link' \
		| while read link; do \
			cd ../.install; \
			make dld D_URL="$$link" D_DST="$$HOME/tmp/$${link##*/}"; \
			make li PACKAGE="$$HOME/tmp/$${link##*/}"; \
			make rm RM_FILE="$$HOME/$${link##*/}"; \
		done

atom: ## Install Atom
ifneq (OSX,$(OSFLAG))
	@echo 'TODO:'
# 	cd ../.install
# 	make dld D_URL=$(VSCODE_URL) D_DST=vscode.$(EXT)
# 	make li PACKAGE=vscode.$(EXT)
endif
ifeq (OSX,$(OSFLAG))
	cd ../.install && make i PACKAGE=atom
endif

atom-beta: ## Install Atom Beta
ifneq (OSX,$(OSFLAG))
	@echo 'TODO:'
# 	cd ../.install
# 	make dld D_URL=$(VSCODE_URL) D_DST=vscode.$(EXT)
# 	make li PACKAGE=vscode.$(EXT)
endif
ifeq (OSX,$(OSFLAG))
	cd ../.install && make i PACKAGE=atom-beta
endif


idea: ## Install IntelliJ IDEA
ifeq (LINUX,$(OSFLAG))
	@echo
endif
ifeq (OSX,$(OSFLAG))
	make intellij IDEA_APP=IIU IDEA_OS=mac
endif
ifeq (WIN32,$(OSFLAG))
	@echo
endif

idea-ce: ## Install IntelliJ IDEA CE
ifeq (LINUX,$(OSFLAG))
	@echo
endif
ifeq (OSX,$(OSFLAG))
	make intellij IDEA_APP=IIC IDEA_OS=mac
endif
ifeq (WIN32,$(OSFLAG))
	@echo
endif

pycharm: ## Install IntelliJ PyCharm
ifeq (LINUX,$(OSFLAG))
	@echo
endif
ifeq (OSX,$(OSFLAG))
	make intellij IDEA_APP=PCP IDEA_OS=mac
endif
ifeq (WIN32,$(OSFLAG))
	@echo
endif

pycharm-ce: ## Install IntelliJ PyCharm CE
ifeq (LINUX,$(OSFLAG))
	@echo
endif
ifeq (OSX,$(OSFLAG))
	make intellij IDEA_APP=PCC IDEA_OS=mac
endif
ifeq (WIN32,$(OSFLAG))
	@echo
endif

sublime: ## Install Sublime Text
ifneq (OSX,$(OSFLAG))
	@echo 'TODO:'
# 	cd ../.install
# 	make dld D_URL=$(VSCODE_URL) D_DST=vscode.$(EXT)
# 	make li PACKAGE=vscode.$(EXT)
endif
ifeq (OSX,$(OSFLAG))
	cd ../.install
	link=$(SUBLIME_URL)
	make dld D_URL="$$link" D_DST="$$HOME/tmp/$${link##*/}"
	make li PACKAGE="$$HOME/tmp/$${link##*/}"
	make rm RM_FILE="$$HOME/$${link##*/}"
endif

vscode: ## Install Visual Studio Code
ifneq (OSX,$(OSFLAG))
	@echo 'TODO:'
# 	cd ../.install
# 	make dld D_URL=$(VSCODE_URL) D_DST=vscode.$(EXT)
# 	make li PACKAGE=vscode.$(EXT)
endif
ifeq (OSX,$(OSFLAG))
	cd ../.install && make i PACKAGE=visual-studio-code
endif

vscode-insiders: ## Install Visual Studio Code Insiders
ifneq (OSX,$(OSFLAG))
	@echo 'TODO:'
endif
ifeq (OSX,$(OSFLAG))
	cd ../.install && make i PACKAGE=visual-studio-code-insiders
endif