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

#
# Actual Action Definitions
#

# https://medium.com/@pwaterz/how-to-dual-boot-windows-10-and-ubuntu-18-04-on-the-15-inch-dell-xps-9570-with-nvidia-1050ti-gpu-4b9a2901493d
xps15-9570: ## Install Utils for XPS15 9570
	# Video Card
# 	make --directoru=../.install i PACKAGE="curl"
# 	sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/JackHack96/dell-xps-9570-ubuntu-respin/master/xps-tweaks.sh)"
# 	sudo prime-select intel
# 	sudo prime-select nvidia
	
	# Fix Touchpad
# 	sudo apt-get install xserver-xorg-input-libinput
# 	sudo apt-get remove --purge xserver-xorg-input-synaptics
# 	sudo reboot

	# Improve Battery Life
	sudo apt install update
	sudo apt install tlp tlp-rdw powertop
	sudo tlp start
	sudo powertop --auto-tune
# 	sudo reboot

	# Multi touch gestures
# 	sudo apt git install xdotool wmctrl libinput-tools
# 	sudo gpasswd -a $USER input
# 	gpasswd -a [your-user-name] input
# 	cd ~/Downloads
# 	git clone git@github.com:bulletmark/libinput-gestures.git
# 	cd libinput-gestures
# 	sudo ./libinput-gestures-setup install
# 	libinput-gestures-setup autostart
# 	libinput-gestures-setup start

	# Visual
	make --directory=../.install i PACKAGE="chrome-gnome-shell gnome-tweak-tool plank"

	# Reboot