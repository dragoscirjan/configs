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

#
# Actual Action Definitions
#

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
# 	@echo "$(NOT_IMPLEMENTED_LINUX)"
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

utils-LINUX:
	@echo

utils-OSX:
	@echo Do I need JQ?

utils-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe" FILE="../bin/jq.exe"

intellij: utils-$(OSFLAG) intellij-$(OSFLAG)

intellij-LINUX:

intellij-OSX:

intellij-WIN32:
	$(POWERSHELL) -File ./intellij.ps1 --keys $(INTELLIJ_APP) --url "https://data.services.jetbrains.com/products/releases?code=$(INTELLIJ_APP)&latest=true&type=release&build=&_=$(TIMESTAMP_SECCONDS)"

ATOM_MODE=stable
# ATOM_MODE=beta
atom: atom-$(OSFLAG) ## Install Atom

atom-LINUX: atom-$(OSID)

atom-ubuntu: atom-debian

atom-debian: atom-debian-$(ATOM_MODE)

atom-debian-stable: 
	make --directory=$(DIR_INSTALL) iu URL="https://atom-installer.github.com/v1.39.1/atom-amd64.deb?s=$(shell date +%s)&ext=.deb" FILE="~/tmp/atom.deb"

atom-debian-beta:
	make --directory=$(DIR_INSTALL) iu URL="https://atom-installer.github.com/v1.40.0-beta1/atom-amd64.deb?s=$(shell date +%s)&ext=.deb" FILE="~/tmp/atom.deb"

atom-OSX:
	make --directory=../.install i PACKAGE=atom$$(test "$(ATOM_MODE)" == "beta" && echo "-beta")

atom-WIN32:
ifeq (beta,$(ATOM_MODE))
	make --directory=$(DIR_INSTALL) iu URL="https://atom.io/download/windows_x64?channel=beta" FILE="~/tmp/atom-beta.exe"
else
	make --directory=$(DIR_INSTALL) iu URL=https://atom.io/download/windows_x64 FILE="~/tmp/atom.exe"
endif

idea: ## Install IntelliJ IDEA
	make intellij INTELLIJ_APP=IIU

idea-ce: ## Install IntelliJ IDEA CE
	make intellij INTELLIJ_APP=IIC

pycharm: ## Install IntelliJ PyCharm
	make intellij INTELLIJ_APP=PCP

pycharm-ce: ## Install IntelliJ PyCharm CE
	make intellij INTELLIJ_APP=PCC

sublime: sublime-$(OSFLAG) ## Install Sublime Text

sublime-LINUX: sublime-$(OSID)

sublime-ubuntu: sublime-debian

sublime-debian:
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	make --directory=$(DIR_INSTALL) i PACKAGE=sublime-text

sublime-centos: sublime-redhat

sublime-redhat:
	sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
	sudo yum-config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
	sudo yum install sublime-text

sublime-fedora:
	sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
	sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
	sudo dnf install sublime-text

sublime-OSX:
# 	make --directory=$(DIR_INSTALL) iu URL="https://download.sublimetext.com/Sublime%20Text%20Build%203207%20x64%20Setup.exe" FILE="~/tmp/sublime.exe"

sublime-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://download.sublimetext.com/Sublime%20Text%20Build%203207%20x64%20Setup.exe" FILE="~/tmp/sublime.exe"

VSCODE=stable
# VSCODE=insider
vscode: vscode-$(OSFLAG) ## Install Visual Studio Code

vscode-LINUX: vscode-$(OSID)

vscode-ubuntu: vscode-debian

vscode-debian:
	make --directory=$(DIR_INSTALL) iu URL="https://update.code.visualstudio.com/latest/linux-deb-x64/$(VSCODE)" FILE="~/tmp/vscode.deb"

# vscode-centos: vscode-redhat
# vscode-fedora: vscode-redhat

# vscode-redhat:
# 	make --directory=$(DIR_INSTALL) iu URL="https://update.code.visualstudio.com/latest/linux-deb-x64/$(VSCODE)" FILE="~/tmp/vscode.deb"



vscode-OSX:
	cd ../.install && make i PACKAGE=visual-studio-code

vscode-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://update.code.visualstudio.com/latest/win32-x64/$(VSCODE)" FILE="~/tmp/vscode.exe"
