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
# Actual Action Definitions
#

LINUX_NOT_IMPLEMENTED = "Not implemented under Linux"
OSX_NOT_IMPLEMENTED = "Not implemented under OSX"
WINDOWS_NOT_IMPLEMENTED = "Not implemented under Windows"

POWERSHELL=powershell -ExecutionPolicy ByPass

DIR_INSTALL = ../.install

CURL=curl -SL
# INTELLIJ_APP=CL # CLion
# INTELLIJ_APP=IIC # Idea CE
# INTELLIJ_APP=IIU # Idea
# INTELLIJ_APP=GO # GoLand
# INTELLIJ_APP=PS # PhpStorm
# INTELLIJ_APP=PCC # PyCharm CE
# INTELLIJ_APP=PCP # PyCharm
# INTELLIJ_APP=RM # RubyMine
# INTELLIJ_APP=WS # WebStorm
INTELLIJ_APP=
INTELLIJ_OS=linux
JQ=jq
TIMESTAMP_SECCONDS=$(shell date +%s)

# ifeq (LINUX,$(OSFLAG))
# 	@echo "$(LINUX_NOT_IMPLEMENTED)"
# endif
ifeq (OSX,$(OSFLAG))
	INTELLIJ_OS=mac
endif
ifeq (WIN32,$(OSFLAG))
	INTELLIJ_OS=windows
	JQ=../bin/jq.exe
	TIMESTAMP_SECCONDS=$(shell powershell "(New-TimeSpan -Start (Get-Date \"01/01/1970\") -End (Get-Date)).TotalSeconds")
endif
ifeq (powershell,$(SHELL_IS))
	CURL=powershell -ExecutionPolicy ByPass -File ../.ps/curl.ps1 --url
endif

# ifeq (LINUX,$(OSFLAG))
# ifeq (debian,$(shell test -f $(which dpkg 2> /dev/null) && echo 'debian'))
# 	EXT=deb

# 	SUBLIME_URL=$(shell curl -sSL https://www.sublimetext.com | grep "Download for Mac" | awk -F'"' '{ print $$4 }')
# 	VSCODE_URL=https://update.code.visualstudio.com/latest/linux-deb-x64/stable
# endif
# ifeq (debian,$(shell test -f $(which rpm 2> /dev/null) && echo 'debian'))
# 	EXT=rpm

# 	SUBLIME_URL=$(shell curl -sSL https://www.sublimetext.com | grep "Download for Mac" | awk -F'"' '{ print $$4 }')
# 	VSCODE_URL=https://update.code.visualstudio.com/latest/linux-rpm-x64/stable
# endif
# 	RM=rm -rf
# 	TIMESTAMP_SECCONDS=$(shell date +%s)
# endif
# ifeq (OSX,$(OSFLAG))
# 	TIMESTAMP_SECCONDS=$(shell date +%s)
# 	EXT=dmg

# 	SUBLIME_URL=$(shell curl -sSL https://www.sublimetext.com | grep "Download for Mac" | awk -F'"' '{ print $$4 }')
# 	VSCODE_URL=https://update.code.visualstudio.com/latest/darwin/stable
# endif
# ifeq (WIN32,$(OSFLAG))
# 	EXT=exe

# 	SUBLIME_URL=$(shell curl -sSL https://www.sublimetext.com | grep "Download for Mac" | awk -F'"' '{ print $$4 }')
# 	VSCODE_URL=
# 	TIMESTAMP_SECCONDS=$(shell date +%s)
# endif


intellij: mktmp winutils
ifeq (shell,$(SHELL_IS))
else
	$(POWERSHELL) -File ./intellij.ps1 --url "https://data.services.jetbrains.com/products/releases?code=$(INTELLIJ_APP)&latest=true&type=release&build=&_=$(TIMESTAMP_SECCONDS)"
endif
# 	if [ "$(INTELLIJ_APP)" == "" ]; then \	
# 	fi
# 	$(CURL) "https://data.services.jetbrains.com/products/releases?code=$(INTELLIJ_APP)&latest=true&type=release&build=&_=$(TIMESTAMP_SECCONDS)"
# 		| $(JQ) -r 'keys[] as $$k | .[$$k] | .[0] | .downloads.$(INTELLIJ_OS).link' \
# 		| while read link; do \
# 			echo $$link; \
# 			echo ~/tmp/$$(echo $$link | awk -F'/' '{print $$NF}'); \
# 		done
# 			make --directory=$(DIR_INSTALL) iu URL="$$link" FILE="~/tmp/$$(echo $$link | awk -F'/' '{print $$NF}')"; \

mktmp:
ifeq (bash,$(SHELL_IS))
	mkdir -p $$HOME/tmp
else
	$(POWERSHELL) "New-Item -Force -Path $$HOME -Name tmp -ItemType directory"
endif

winutils:
	$(POWERSHELL) "if (Test-Path -Path ../bin/jq.exe) { exit 0 } 
# 	make --directory=$(DIR_INSTALL) dld URL="https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe" FILE="../bin/jq.exe"

ATOM_MODE=stabel
# ATOM_MODE=beta
atom: mktmp ## Install Atom
ifeq (LINUX,$(OSFLAG))
	@echo "$(LINUX_NOT_IMPLEMENTED)"
endif
ifeq (OSX,$(OSFLAG))
	cd ../.install && make i PACKAGE=atom$$(test "$(ATOM_MODE)" == "beta" && echo "-beta")
endif
ifeq (WIN32,$(OSFLAG))
ifeq (beta,$(ATOM_MODE))
	make --directory=$(DIR_INSTALL) iu URL="https://atom.io/download/windows_x64?channel=beta" FILE="~/tmp/atom-beta.exe"
else
	make --directory=$(DIR_INSTALL) iu URL=https://atom.io/download/windows_x64 FILE="~/tmp/atom.exe"
endif
endif

idea: ## Install IntelliJ IDEA
# ifeq (LINUX,$(OSFLAG))
# 	@echo
# endif
# ifeq (OSX,$(OSFLAG))
	make intellij INTELLIJ_APP=IIU
# endif
# ifeq (WIN32,$(OSFLAG))
# 	@echo
# endif

# idea-ce: ## Install IntelliJ IDEA CE
# ifeq (LINUX,$(OSFLAG))
# 	@echo
# endif
# ifeq (OSX,$(OSFLAG))
# 	make intellij INTELLIJ_APP=IIC INTELLIJ_OS=mac
# endif
# ifeq (WIN32,$(OSFLAG))
# 	@echo
# endif

# pycharm: ## Install IntelliJ PyCharm
# ifeq (LINUX,$(OSFLAG))
# 	@echo
# endif
# ifeq (OSX,$(OSFLAG))
# 	make intellij INTELLIJ_APP=PCP INTELLIJ_OS=mac
# endif
# ifeq (WIN32,$(OSFLAG))
# 	@echo
# endif

# pycharm-ce: ## Install IntelliJ PyCharm CE
# ifeq (LINUX,$(OSFLAG))
# 	@echo
# endif
# ifeq (OSX,$(OSFLAG))
# 	make intellij INTELLIJ_APP=PCC INTELLIJ_OS=mac
# endif
# ifeq (WIN32,$(OSFLAG))
# 	@echo
# endif

sublime: ## Install Sublime Text
ifeq (LINUX,$(OSFLAG))
	@echo "$(LINUX_NOT_IMPLEMENTED)"
endif
ifeq (OSX,$(OSFLAG))
	cd ../.install
	link=$(SUBLIME_URL)
	make dld D_URL="$$link" D_DST="$$HOME/tmp/$${link##*/}"
	make li PACKAGE="$$HOME/tmp/$${link##*/}"
	make rm RM_FILE="$$HOME/$${link##*/}"
endif
ifeq (WIN32,$(OSFLAG))
	make --directory=$(DIR_INSTALL) iu URL="https://download.sublimetext.com/Sublime%20Text%20Build%203207%20x64%20Setup.exe" FILE="~/tmp/sublime.exe" IL_WIN_ARGS="/silent /norestart"
endif

vscode: ## Install Visual Studio Code
ifeq (LINUX,$(OSFLAG))
	@echo "$(LINUX_NOT_IMPLEMENTED)"
endif
ifeq (OSX,$(OSFLAG))
	cd ../.install && make i PACKAGE=visual-studio-code
endif
ifeq (WIN32,$(OSFLAG))
	make --directory=$(DIR_INSTALL) iu URL="https://update.code.visualstudio.com/latest/win32-x64/stable" FILE="~/tmp/vscode.exe" IL_WIN_ARGS="/silent /norestart"
endif

vscode-insiders: ## Install Visual Studio Code Insiders
ifeq (LINUX,$(OSFLAG))
	@echo "$(LINUX_NOT_IMPLEMENTED)"
endif
ifeq (OSX,$(OSFLAG))
	cd ../.install && make i PACKAGE=visual-studio-code-insiders
endif
ifeq (WIN32,$(OSFLAG))
	make --directory=$(DIR_INSTALL) iu URL="https://update.code.visualstudio.com/latest/win32-x64/insider" FILE="~/tmp/vscode-insider.exe" IL_WIN_ARGS="/silent /norestart"
endif