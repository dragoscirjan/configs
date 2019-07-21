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
#
#

ifeq (bash,$(SHELL_IS))
	CURL=curl -SL
else
	CURL=powershell -ExecutionPolicy ByPass -File ../.ps/curl.ps1 --url
endif

LINUX_NOT_IMPLEMENTED = "Not implemented under Linux"
OSX_NOT_IMPLEMENTED = "Not implemented under OSX"
WINDOWS_NOT_IMPLEMENTED = "Not implemented under Windows"

#
# Utils
#

apt-utils:
ifeq (LINUX,$(OSFLAG))
	which apt > /dev/null && sudo apt install apt-transport-https
	which apt-get > /dev/null && sudo apt-get install apt-transport-https
endif

dld: ## Download file from web for installing: make dld URL=http://... FILE=./file.exe
ifeq (bash,$(SHELL_IS))
	$(CURL) "$(URL)" --output "$(FILE)"
else
	$(CURL) "$(URL)" --output "$(FILE)"
endif

rm: ## Remove file 
ifeq (bash,$(SHELL_IS))
	rm -rf "$(FILE)"
else
	rm "$(FILE)"
endif

#
# Install Commands
#

# i: apt-utils ## Install Package Depending on OS
# ifeq (WIN32, $(OSFLAG))
# 	choko install $(PACKAGE)
# endif
# ifeq (OSX, $(OSFLAG))
# 	brew install $(PACKAGE) || brew cask install $(PACKAGE)
# endif
# ifeq (LINUX,$(OSFLAG))
# 	which apt > /dev/null && sudo apt install -y $(PACKAGE)
# 	which apt-get > /dev/null && sudo apt-get install -y $(PACKAGE)
# 	which yum > /dev/null && sudo yum install -y $(PACKAGE)
# 	which dnf > /dev/null && sudo dnf install -y $(PACKAGE)
# endif

il: apt-utils ## Install Local Package Depending on OS
# ifeq (LINUX,$(OSFLAG))
# 	which dpkg > /dev/null && sudo dpkg -i $(PACKAGE) || apt-get install -f
# 	which rpm > /dev/null && sudo rpm -i $(PACKAGE)
# endif
# ifeq (OSX, $(OSFLAG))
# 	# http://commandlinemac.blogspot.com/2008/12/installing-dmg-application-from-command.html
# 	hdiutil mount $(PACKAGE) -mountpoint $$HOME/tmp/volume
# 	find /Users/dragos.cirjan/tmp/volume -type d -iname "*.app" -mindepth 1 -maxdepth 1 \
# 		| while read app; do sudo cp -R "$$app" /Applications; done
# 	find /Users/dragos.cirjan/tmp/volume -type f -iname "*.pkg" -mindepth 1 -maxdepth 1 \
# 		| while read app; do echo sudo installer -package $$app -target "/Volumes/Macintosh HD"; done
# 	hdiutil unmount $$HOME/tmp/volume
# endif
ifeq (WIN32, $(OSFLAG))
	powershell -ExecutionPolicy ByPass -Command "Start-Process "$(FILE)" -NoNewWindow -Wait $(IL_WIN_ARGS)"
endif

iu: ## Install URL Package Depending on OS
ifeq (LINUX,$(OSFLAG))
	@echo "$(LINUX_NOT_IMPLEMENTED)"
endif
ifeq (OSX,$(OSFLAG))
	@echo "$(OSX_NOT_IMPLEMENTED)"
endif
ifeq (WIN32,$(OSFLAG))
	make dld
	make il PACKAGE="$(FILE)"
	make rm
endif
endif
