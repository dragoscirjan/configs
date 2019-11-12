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
# Actual Action Definitions
#

NOT_IMPLEMENTED_LINUX = "Not implemented under Linux"
NOT_IMPLEMENTED_OSX = "Not implemented under OSX"
NOT_IMPLEMENTED_WINDOWS = "Not implemented under Windows"

POWERSHELL=powershell -ExecutionPolicy ByPass

DIR_INSTALL = ../.install

mktmp:
ifeq (bash,$(SHELL_IS))
	mkdir -p $$HOME/tmp
else
	$(POWERSHELL) "New-Item -Force -Path $$HOME -Name tmp -ItemType directory"
endif

chrome: ## Install Google Chrome Browser

chrome-LINUX:
	xdg-open https://www.google.com/chrome/ || gnome-open https://www.google.com/chrome/

chrome-OSX:
	cd ../.install && make i PACKAGE=atom$$(test "$(ATOM_MODE)" == "beta" && echo "-beta")

chrome-WIN32:
	powershell -ExecutionPolicy ByPass -Command " Start-Process -FilePath https://www.google.com/chrome/"


chromium: chromium-$(OSFLAG) ## Install Chromium Browser

chromium-LINUX:
	make --directory=$(DIR_INSTALL) i PACKAGE=chromium-browser

chromium-OSX:
	@echo "$(NOT_IMPLEMENTED_OSX)"

chromium-WIN32:
	@echo "$(NOT_IMPLEMENTED_WINDOWS)"


EDGE=edge
edge: ## Install Edge Browser
	
edge-LINUX-edge:
	echo "$(NOT_IMPLEMENTED_LINUX)"

edge-LINUX-insider:
	echo "$(NOT_IMPLEMENTED_LINUX)"

edge-OSX-edge:
	echo "$(NOT_IMPLEMENTED_OSX)"

edge-OSX-insider:
	echo "$(NOT_IMPLEMENTED_OSX)"

edge-WIN32-edge:
	echo "This one should already be installed."

edge-WIN32-insider:
	make --directory=$(DIR_INSTALL) iu URL="https://go.microsoft.com/fwlink/?linkid=2084648&Channel=Dev&language=en&Consent=0&IID=83b0690a-dfc9-5ed4-a7c8-658186f0b70f" FILE="~/tmp/edge.exe"


FIREFOX=firefox
firefox: firefox-$(OSFLAG)-$(FIREFOX) ## Install Firefox Browser FIREFOX=firefox,aurora

firefox-LINUX-firefox:
	make --directory=$(DIR_INSTALL) i PACKAGE=firefox

firefox-LINUX-aurora:
	make --directory=$(DIR_INSTALL) dld URL="https://download-installer.cdn.mozilla.net/pub/devedition/releases/69.0b11/linux-x86_64/en-US/firefox-69.0b11.tar.bz2" FILE="~/bin/firefox.tar.bz2"
	cd ~/bin && tar -xjvf firefox.tar.bz2 && ln -s ./firefox/firefox ./firefox-aurora

firefox-OSX-firefox:
	make --directory=$(DIR_INSTALL) i PACKAGE=firefox

firefox-OSX-aurora:
	make --directory=$(DIR_INSTALL) i PACKAGE=firefox-developer-edition BREW_SOURCE=cask

firefox-WIN32-firefox:
	make --directory=$(DIR_INSTALL) iu URL="https://download.mozilla.org/?product=firefox-devedition-stub&os=win&lang=en-US" FILE="~/tmp/firefox.exe"

firefox-WIN32-aurora:
	make --directory=$(DIR_INSTALL) iu URL="https://download.mozilla.org/?product=firefox-stub&os=win&lang=en-US" FILE="~/tmp/firefox.exe"


OPERA=opera
opera: opera-$(OSFLAG)-$(OPERA) ## Install Opera Browser

opera-LINUX-opera: opera-$(OSID)-$(OPERA)

opera-ubuntu-opera: opera-debian-opera

opera-debian-opera:
	make --directory=$(DIR_INSTALL) iu URL="https://download3.operacdn.com/pub/opera/desktop/62.0.3331.99/linux/opera-stable_62.0.3331.99_amd64.deb" FILE="~/tmp/opera.deb"

opera-LINUX-neon:
	echo $(NOT_IMPLEMENTED_LINUX)

opera-OSX-opera:
	echo $(NOT_IMPLEMENTED_OSX)

opera-OSX-neon:
	echo $(NOT_IMPLEMENTED_OSX)

opera-WIN32-opera:
	make --directory=$(DIR_INSTALL) iu URL="http://get.geo.opera.com/.private/OperaNeonSetup.exe?utm_tryagain=yes" FILE="~/tmp/opera.exe"

opera-WIN32-neon:
	make --directory=$(DIR_INSTALL) iu URL="https://net.geo.opera.com/opera/stable/windows?http_referrer=missing_via_opera_com&utm_source=(direct)_via_opera_com&utm_medium=doc&utm_campaign=(direct)_via_opera_com_https&utm_lastpage=opera.com/&utm_tryagain=yes" FILE="~/tmp/opera.exe"


vivaldi: vivaldi-$(OSFLAG) ## Install Vivaldi Browser

vivaldi-LINUX: vivaldi-$(OSID)

vivaldi-ubuntu: vivaldi-debian

vivaldi-debian:
	make --directory=$(DIR_INSTALL) iu URL="https://downloads.vivaldi.com/stable/vivaldi-stable_2.6.1566.49-1_amd64.deb" FILE="~/tmp/vivaldi.deb"
	
vivalid-OSX:
	cd ../.install && make i PACKAGE=atom$$(test "$(ATOM_MODE)" == "beta" && echo "-beta")

vivaldi-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://downloads.vivaldi.com/stable/Vivaldi.2.6.1566.49.exe" FILE="~/tmp/vivaldi.exe"
