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

POWERSHELL=powershell -ExecutionPolicy ByPass

ifeq (bash,$(SHELL_IS))
	CURL=curl -SL
else
	CURL=$(POWERSHELL) -File ../.ps/curl.ps1 --url
endif

#
# ENV
#

NOT_IMPLEMENTED_LINUX = "Not implemented under Linux"
NOT_IMPLEMENTED_OSX = "Not implemented under OSX"
NOT_IMPLEMENTED_WINDOWS = "Not implemented under Windows"

IL_WIN_ARGS ?= ''

#
# Actual Action Definitions
#

#
# Utils
#

mktmp: mktmp-$(SHELL_IS)

mktmp-bash:
	mkdir -p ~/tmp

mktmp-powershell:
	$(POWERSHELL) -Command "New-Item -Force -Path $$HOME -Name tmp -ItemType directory"

mkbin: mkbin-$(SHELL_IS)

mkbin-bash:
	mkdir -p ~/bin

mkbin-powershell:
	$(POWERSHELL) -Command "New-Item -Force -Path $$HOME -Name bin -ItemType directory"

apt-utils:
ifeq (LINUX,$(OSFLAG))
	which apt > /dev/null && sudo apt install apt-transport-https
	which apt-get > /dev/null && sudo apt-get install -y apt-transport-https curl bzip2 gzip
endif

#
# Download File
#

dld:  apt-utils mktmp mkbin dld-$(SHELL_IS) ## Download file from web for installing: make dld URL=http://... FILE=./file.exe

dld-bash:
	$(CURL) "$(URL)" --output $(FILE)

dld-powershell:
	$(CURL) "$(URL)" --output "$(FILE)"

#
# Remove FIle
#

rm: rm-$(SHELL_IS) ## Remove file

rm-bash: 
	rm -rf "$(FILE)"

rm-powershell:
	rm "$(FILE)"

#
# Install Package
#

i: apt-utils i-$(OSFLAG) ## Install Package Depending on OS BREW_SOURCE=,cask

i-LINUX: i-$(OSID)

i-ubuntu:
	sudo apt update
	sudo apt install -y $(PACKAGE)

i-debian:
	sudo apt-get update
	sudo apt-get install -y $(PACKAGE)

# 	which dnf > /dev/null && sudo dnf install -y $(PACKAGE)
# 	which yum > /dev/null && sudo yum install -y $(PACKAGE)

BREW_SOURCE=
# BREW_SOURCE=cask
i-OSX:
	brew $(BREW_SOURCE) install $(PACKAGE) || brew $(BREW_SOURCE) reinstall $(PACKAGE)

i-WIN32:
	choko install $(PACKAGE)

#
# Install from Local File
#

il: apt-utils il-$(OSFLAG)-$(SHELL_IS) ## Install Local Package Depending on OS

il-LINUX-bash: il-LINUX-bash-$(OSID)

il-LINUX-bash-ubuntu: il-LINUX-bash-debian

il-LINUX-bash-debian:
	sudo dpkg -i $(FILE) || sudo apt-get install -fy

il-OSX-bash:
	# http://commandlinemac.blogspot.com/2008/12/installing-dmg-application-from-command.html
	hdiutil mount $(FILE) -mountpoint $$HOME/tmp/volume
	find /Users/dragos.cirjan/tmp/volume -type d -iname "*.app" -mindepth 1 -maxdepth 1 \
		| while read app; do sudo cp -R "$$app" /Applications; done
	find /Users/dragos.cirjan/tmp/volume -type f -iname "*.pkg" -mindepth 1 -maxdepth 1 \
		| while read app; do echo sudo installer -package $$app -target "/Volumes/Macintosh HD"; done
	hdiutil unmount $$HOME/tmp/volume

il-WIN32-bash: 
	$(POWERSHELL) -File ../.ps/install.ps1 --file "$(FILE)" --args "$(IL_WIN_ARGS)"

il-WIN32-powershell: il-WIN32-bash


#
# Install from URL
#

iu: dld iu-$(OSFLAG)-$(SHELL_IS) ## Install URL Package Depending on OS

iu-LINUX-bash:
	make il-LINUX-bash FILE="$(FILE)"
	make rm

iu-OSX-bash:
	@echo "$(NOT_IMPLEMENTED_OSX)"

iu-WIN32-bash:
	make il-WIN32-bash FILE="$(FILE)" IL_WIN_ARGS=$(IL_WIN_ARGS)
	make rm

iu-WIN32-powershell: iu-WIN32-bash
