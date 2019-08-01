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

DIR_INSTALL = ../.install

#
# Utils
#

mkfont: mkfont-$(SHELL_IS)

mkfont-bash:
	make --directory=$(DIR_INSTALL) mktmp
	mkdir -p ~/tmp/font

mkfont-powershell:
	make --directory=$(DIR_INSTALL) mktmp
	$(POWERSHELL) -Command "New-Item -Force -Path $$HOME/tmp -Name font -ItemType directory"

#
# Actual Action Definitions
#

firacode: firacode-$(OSFLAG) ## Install Fira Code Font https://github.com/tonsky/FiraCode
	make --directory=$(DIR_INSTALL) rm FILE="~/tmp/fonts"

firacode-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

firacode-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

firacode-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://github.com/tonsky/FiraCode/releases/download/1.206/FiraCode_1.206.zip" FILE="~/tmp/fonts.zip"
	$(POWERSHELL) -Command "Expand-Archive -Force ~/tmp/fonts.zip -DestinationPath ~/tmp/fonts"
	$(POWERSHELL) -File ../.ps/install-font.ps1


sourcecodepro: mkfont sourcecodepro-$(OSFLAG) ## Install Source Code Pro Font https://github.com/adobe-fonts/source-code-pro
	make --directory=$(DIR_INSTALL) rm FILE="~/tmp/fonts"

sourcecodepro-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

sourcecodepro-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

sourcecodepro-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Italic.ttf" FILE="~/tmp/fonts/SourceCodeVariable-Italic.ttf"
	make --directory=$(DIR_INSTALL) dld URL="https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Roman.ttf" FILE="~/tmp/fonts/SourceCodeVariable-Roman.ttf"
	$(POWERSHELL) -File ../.ps/install-font.ps1

all: firacode sourcecodepro ## Install all Fonts