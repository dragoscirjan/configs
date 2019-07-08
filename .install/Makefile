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

apt-utils:
	which apt > /dev/null && sudo apt install apt-transport-https
	which apt-get > /dev/null && sudo apt-get install apt-transport-https

i: apt-utils ## Install Package Depending on OS
ifeq (WIN32, $(OSFLAG))
	choko install $(PACKAGE)
endif
ifeq (OSX, $(OSFLAG))
	brew install $(PACKAGE) || brew cask install $(PACKAGE)
endif
ifeq (LINUX,$(OSFLAG))
	which apt > /dev/null && sudo apt install -y $(PACKAGE)
	which apt-get > /dev/null && sudo apt-get install -y $(PACKAGE)
	which yum > /dev/null && sudo yum install -y $(PACKAGE)
	which dnf > /dev/null && sudo dnf install -y $(PACKAGE)
endif

li: apt-utils ## Install Local Package Depending on OS
ifeq (WIN32, $(OSFLAG))
	$(PACKAGE)
endif
ifeq (OSX, $(OSFLAG))
	@echo 'This is a TODO:'
endif
ifeq (LINUX,$(OSFLAG))
	which dpkg > /dev/null && sudo dpkg -i $(PACKAGE) || apt-get install -f
	which rpm > /dev/null && sudo rpm -i $(PACKAGE)
endif

D_URL=
D_DST=

dld: ## Download file from web for installing: make dld D_URL=http://... D_DST=./file.exe
ifeq (WIN32,$(OSFLAG))
	@echo 'To Be Implemented'
else
	curl -sSL $(DOWNLOAD_URL) > $(DOWNLOAD_DST)
endif

