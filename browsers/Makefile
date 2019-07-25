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

mktmp:
ifeq (bash,$(SHELL_IS))
	mkdir -p $$HOME/tmp
else
	$(POWERSHELL) "New-Item -Force -Path $$HOME -Name tmp -ItemType directory"
endif

chrome:
ifeq (LINUX,$(OSFLAG))
	@echo "$(LINUX_NOT_IMPLEMENTED)"
endif
ifeq (OSX,$(OSFLAG))
	cd ../.install && make i PACKAGE=atom$$(test "$(ATOM_MODE)" == "beta" && echo "-beta")
endif
ifeq (WIN32,$(OSFLAG))
	powershell -ExecutionPolicy ByPass -Command " Start-Process -FilePath https://www.google.com/chrome/"
endif

edge:
ifeq (WIN32,$(OSFLAG))
ifeq (insider,$(EDGE))
	make --directory=$(DIR_INSTALL) iu URL="https://go.microsoft.com/fwlink/?linkid=2084648&Channel=Dev&language=en&Consent=0&IID=83b0690a-dfc9-5ed4-a7c8-658186f0b70f" FILE="~/tmp/edge.exe"
else
	echo "This one should already be installed."
endif
endif

FIREFOX=
firefox:
ifeq (LINUX,$(OSFLAG))
	@echo "$(LINUX_NOT_IMPLEMENTED)"
endif
ifeq (OSX,$(OSFLAG))
	cd ../.install && make i PACKAGE=atom$$(test "$(ATOM_MODE)" == "beta" && echo "-beta")
endif
ifeq (WIN32,$(OSFLAG))
ifeq (aurora,$(FIREFOX))
	make --directory=$(DIR_INSTALL) iu URL="https://download.mozilla.org/?product=firefox-devedition-stub&os=win&lang=en-US" FILE="~/tmp/firefox.exe"
else
	make --directory=$(DIR_INSTALL) iu URL="https://download.mozilla.org/?product=firefox-stub&os=win&lang=en-US" FILE="~/tmp/firefox.exe"
endif
endif

OPERA=
opera:
ifeq (LINUX,$(OSFLAG))
	@echo "$(LINUX_NOT_IMPLEMENTED)"
endif
ifeq (OSX,$(OSFLAG))
	cd ../.install && make i PACKAGE=atom$$(test "$(ATOM_MODE)" == "beta" && echo "-beta")
endif
ifeq (WIN32,$(OSFLAG))
ifeq (neon,$(OPERA))
	make --directory=$(DIR_INSTALL) iu URL="http://get.geo.opera.com/.private/OperaNeonSetup.exe?utm_tryagain=yes" FILE="~/tmp/opera.exe"
else
	make --directory=$(DIR_INSTALL) iu URL="https://net.geo.opera.com/opera/stable/windows?http_referrer=missing_via_opera_com&utm_source=(direct)_via_opera_com&utm_medium=doc&utm_campaign=(direct)_via_opera_com_https&utm_lastpage=opera.com/&utm_tryagain=yes" FILE="~/tmp/opera.exe"
endif
endif

vivaldi:
ifeq (LINUX,$(OSFLAG))
	@echo "$(LINUX_NOT_IMPLEMENTED)"
endif
ifeq (OSX,$(OSFLAG))
	cd ../.install && make i PACKAGE=atom$$(test "$(ATOM_MODE)" == "beta" && echo "-beta")
endif
ifeq (WIN32,$(OSFLAG))
	make --directory=$(DIR_INSTALL) iu URL="https://downloads.vivaldi.com/stable/Vivaldi.2.6.1566.49.exe" FILE="~/tmp/vivaldi.exe"
endif