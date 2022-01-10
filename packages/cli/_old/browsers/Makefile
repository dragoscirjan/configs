include ../Makefile.template

#
# Actual Action Definitions
#

POWERSHELL=powershell -ExecutionPolicy ByPass

DIR_INSTALL = ../.install

mktmp:
ifeq (bash,$(SHELL_IS))
	mkdir -p $$HOME/tmp
else
	$(POWERSHELL) "New-Item -Force -Path $$HOME -Name tmp -ItemType directory"
endif

all: chrome edge firefox opera vivaldi ## Install all browsers (without dev versions)

chrome: chrome-$(OSFLAG) ## Install Google Chrome Browser

# chrome-LINUX:
# 	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.google.com/chrome/" PACKAGE_MATCH="ChromeSetup.exe" PACKAGE_ARGS="/silent /install"

# chrome-OSX:
# 	make --directory=$(DIR_INSTALL) i PACKAGE=google-chrome BREW_SOURCE=cask

chrome-WIN32:
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.google.com/chrome/" PACKAGE_MATCH="ChromeSetup.exe" PACKAGE_ARGS="/silent /install"


chromium: chromium-$(OSFLAG) ## Install Chromium Browser

# chromium-LINUX:
# 	make --directory=$(DIR_INSTALL) i PACKAGE=chromium-browser BREW_SOURCE

# chromium-OSX:
# 	@echo "$(NOT_IMPLEMENTED_OSX)"

chromium-WIN32:
	$(POWERSHELL) -File .\chromium-install.ps1


edge: edge-$(OSFLAG) ## Install Edge Browser EDGE=edge,insider

edge-WIN32:
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.microsoft.com/en-us/edge" PACKAGE_MATCH="MicrosoftEdgeSetup.exe" PACKAGE_ARGS="/silent /install"


FIREFOX=firefox
firefox: firefox-$(OSFLAG)-$(FIREFOX) ## Install Firefox Browser FIREFOX=firefox,aurora

# firefox-LINUX-firefox:
# 	make --directory=$(DIR_INSTALL) i PACKAGE=firefox BREW_SOURCE=cask

# firefox-LINUX-aurora:
# 	make --directory=$(DIR_INSTALL) dld URL="https://download-installer.cdn.mozilla.net/pub/devedition/releases/69.0b11/linux-x86_64/en-US/firefox-69.0b11.tar.bz2" FILE="~/bin/firefox.tar.bz2"
# 	cd ~/bin && tar -xjvf firefox.tar.bz2 && ln -s ./firefox/firefox ./firefox-aurora

# firefox-OSX-firefox:
# 	make --directory=$(DIR_INSTALL) i PACKAGE=firefox BREW_SOURCE=cask

# firefox-OSX-aurora:
# 	make --directory=$(DIR_INSTALL) i PACKAGE=firefox-developer-edition BREW_SOURCE=cask

firefox-WIN32-firefox:
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://download.mozilla.org/?product=firefox-stub&os=win&lang=en-US" PACKAGE_MATCH="Firefox.*Installer.exe" PACKAGE_ARGS="/S"

firefox-WIN32-aurora:
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://download.mozilla.org/?product=firefox-devedition-stub&os=win&lang=en-US" PACKAGE_MATCH="Firefox.*Installer.exe" PACKAGE_ARGS="/S"


OPERA=opera
opera: opera-$(OSFLAG)-$(OPERA) ## Install Opera Browser OPERA=opera,neon

# opera-LINUX-opera: opera-$(OSID)-$(OPERA)

# opera-ubuntu-opera: opera-debian-opera

# opera-debian-opera:
# 	make --directory=$(DIR_INSTALL) iu URL="https://download3.operacdn.com/pub/opera/desktop/65.0.3467.69/linux/opera-stable_65.0.3467.69_amd64.deb" FILE="~/tmp/opera.deb"

# opera-LINUX-neon:
# 	echo $(NOT_IMPLEMENTED_LINUX)

# opera-OSX-opera:
# 	make --directory=$(DIR_INSTALL) i PACKAGE=opera BREW_SOURCE=cask

# opera-OSX-neon:
# 	make --directory=$(DIR_INSTALL) i PACKAGE=opera-neon BREW_SOURCE=cask

opera-WIN32-opera:
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.opera.com/computer/thanks?ni=stable&os=windows" PACKAGE_MATCH="OperaSetup.exe" PACKAGE_ARGS="/silent /norestart /launchopera 0"

opera-WIN32-neon:
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.opera.com/computer/thanks?ni=stable_neon&os=windows" PACKAGE_MATCH="OperaNeonSetup.exe" PACKAGE_ARGS="/silent /norestart /launchoperaneon 0"


tor: tor-$(OSFLAG) ## Install Tor Browser

tor-WIN32:
	# TODO: Should find a way to install somewhere else than desktop
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.torproject.org/download/" PACKAGE_MATCH="torbrowser-install.*.exe" PACKAGE_ARGS="/S"
	#/INI=$(shell powershell -Command "(Get-Location).Path")\tor.ini"


vivaldi: vivaldi-$(OSFLAG) ## Install Vivaldi Browser

# vivaldi-LINUX: vivaldi-$(OSID)

# vivaldi-ubuntu: vivaldi-debian

# vivaldi-debian:
# 	make --directory=$(DIR_INSTALL) iu URL="https://downloads.vivaldi.com/stable/vivaldi-stable_2.6.1566.49-1_amd64.deb" FILE="~/tmp/vivaldi.deb"

# vivaldi-OSX:
# 	make --directory=$(DIR_INSTALL) i PACKAGE=vivaldi BREW_SOURCE=cask

vivaldi-WIN32:
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://vivaldi.com/" PACKAGE_MATCH="Vivaldi.*.exe" PACKAGE_ARGS="--vivaldi-silent --do-not-launch-chrome --vivaldi-update"
