Makefile
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
CURL=curl -sSL
	ifeq (debian,$(shell test -f $(which dpkg 2> /dev/null) && echo 'debian'))
PKM=sudo dpkg -i
PKM_EXT=.deb
VSCODE_URL=https://update.code.visualstudio.com/latest/linux-deb-x64/stable
	endif
	ifeq (debian,$(shell test -f $(which rpm 2> /dev/null) && echo 'debian'))
PKM=sudo rpm -i
PKM_EXT=.rpm
VSCODE_URL=https://update.code.visualstudio.com/latest/linux-rpm-x64/stable
	endif
endif
ifeq (OSX,$(OSFLAG))
CURL=curl -sSL
PKM3=brew cask install
PKM2=brew install 
# PKM=
# PKM_EXT=.dmg
# VSCODE_URL=https://update.code.visualstudio.com/latest/darwin/stable
endif
ifeq (WIN32,$(OSFLAG))
PKM=https://www.powershellgallery.com/packages/Install-VSCode/1.2/Content/Install-VSCode.ps1
PKM_EXT=.exe
VSCODE_URL=https://update.code.visualstudio.com/latest/win32-x64-user/stable
endif


vscode: ## Install Visual Studio Code
ifeq (WIN32,$(OSFLAG))
	@echo 'TODO:'
else
	$(CURL) $(VSCODE_URL) > $(HOME)/vscode.$(PKM_EXT)
ifneq (OSX,$(OSFLAG))
	$(PKM) $(HOME)/vscode.$(PKM_EXT)
	rm -rf $(HOME)/vscode.$(PKM_EXT)
else
	$(PKM3) visual-studio-code
endif
endif