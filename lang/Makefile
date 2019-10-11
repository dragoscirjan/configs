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

#
# ENV
#

NOT_IMPLEMENTED_LINUX = "Not implemented under Linux"
NOT_IMPLEMENTED_OSX = "Not implemented under OSX"
NOT_IMPLEMENTED_WINDOWS = "Not implemented under Windows"

DIR_INSTALL = ../.install

#
# Actual Action Definitions
#

golang: golang-$(OSFLAG) ## Install golang

golang-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

golang-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

golang-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://dl.google.com/go/go1.12.7.windows-amd64.msi" FILE="~/tmp/go-lang.msi"

# JAVA_VERSION=8
JAVA_VERSION=11
JAVA_TYPE=open
# JAVA_TYPE=oracle
java: java-$(OSFLAG) ## Install Java

java-LINUX: java-$(OSID)
	make --directory=$(DIR_INSTALL) i PACKAGE=maven

java-ubuntu: java-debian
java-debian: java-debian-$(JAVA_TYPE)

java-debian-open:
	make --directory=$(DIR_INSTALL) i PACKAGE="openjdk-$(JAVA_VERSION)-jdk openjdk-$(JAVA_VERSION)-jre"

java-debian-oracle:
	sudo add-apt-repository ppa:webupd8team/java

java-OSX:

java-WIN32:


nodejs: nodejs-$(OSFLAG) ## Install NodeJs

nodejs-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

nodejs-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

nodejs-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://nodejs.org/dist/v10.16.1/node-v10.16.1-x64.msi" FILE="~/tmp/node.msi"


python: python-$(OSFLAG) ## Install Python

python-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

python-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

python-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://www.python.org/ftp/python/3.7.4/python-3.7.4.exe" FILE="~/tmp/python.exe"


ruby: ruby-$(OSFLAG) ## Install Ruby

ruby-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

ruby-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

ruby-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-2.6.3-1/rubyinstaller-2.6.3-1-x64.exe" FILE="~/tmp/ruby.exe"