include ./Makefile.template

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

chrome-LINUX:
	xdg-open https://www.google.com/chrome/ || gnome-open https://www.google.com/chrome/

chrome-OSX:
	make --directory=$(DIR_INSTALL) i PACKAGE=google-chrome BREW_SOURCE=cask

chrome-WIN32:
	powershell -ExecutionPolicy ByPass -Command " Start-Process -FilePath https://www.google.com/chrome/"


chromium: chromium-$(OSFLAG) ## Install Chromium Browser

chromium-LINUX:
	make --directory=$(DIR_INSTALL) i PACKAGE=chromium-browser BREW_SOURCE

chromium-OSX:
	@echo "$(NOT_IMPLEMENTED_OSX)"

chromium-WIN32:
	@echo "$(NOT_IMPLEMENTED_WINDOWS)"


EDGE=edge
edge: chromium-$(OSFLAG)-$(EDGE) ## Install Edge Browser EDGE=edge,insider
	
edge-LINUX-edge:
	echo "$(NOT_IMPLEMENTED_LINUX)"

edge-LINUX-insider:
	echo "$(NOT_IMPLEMENTED_LINUX)"

edge-OSX-edge:
	make --directory=$(DIR_INSTALL) i PACKAGE=homebrew/cask-versions/microsoft-edge-beta BREW_SOURCE=cask

edge-OSX-insider:
	make --directory=$(DIR_INSTALL) i PACKAGE=homebrew/cask-versions/microsoft-edge-canary BREW_SOURCE=cask

edge-WIN32-edge:
	echo "This one should already be installed."

edge-WIN32-insider:
	make --directory=$(DIR_INSTALL) iu URL="https://go.microsoft.com/fwlink/?linkid=2084648&Channel=Dev&language=en&Consent=0&IID=83b0690a-dfc9-5ed4-a7c8-658186f0b70f" FILE="~/tmp/edge.exe"


FIREFOX=firefox
firefox: firefox-$(OSFLAG)-$(FIREFOX) ## Install Firefox Browser FIREFOX=firefox,aurora

firefox-LINUX-firefox:
	make --directory=$(DIR_INSTALL) i PACKAGE=firefox BREW_SOURCE=cask

firefox-LINUX-aurora:
	make --directory=$(DIR_INSTALL) dld URL="https://download-installer.cdn.mozilla.net/pub/devedition/releases/69.0b11/linux-x86_64/en-US/firefox-69.0b11.tar.bz2" FILE="~/bin/firefox.tar.bz2"
	cd ~/bin && tar -xjvf firefox.tar.bz2 && ln -s ./firefox/firefox ./firefox-aurora

firefox-OSX-firefox:
	make --directory=$(DIR_INSTALL) i PACKAGE=firefox BREW_SOURCE=cask

firefox-OSX-aurora:
	make --directory=$(DIR_INSTALL) i PACKAGE=firefox-developer-edition BREW_SOURCE=cask

firefox-WIN32-firefox:
	make --directory=$(DIR_INSTALL) iu URL="https://download.mozilla.org/?product=firefox-devedition-stub&os=win&lang=en-US" FILE="~/tmp/firefox.exe"

firefox-WIN32-aurora:
	make --directory=$(DIR_INSTALL) iu URL="https://download.mozilla.org/?product=firefox-stub&os=win&lang=en-US" FILE="~/tmp/firefox.exe"


OPERA=opera
opera: opera-$(OSFLAG)-$(OPERA) ## Install Opera Browser OPERA=opera,neon

opera-LINUX-opera: opera-$(OSID)-$(OPERA)

opera-ubuntu-opera: opera-debian-opera

opera-debian-opera:
	make --directory=$(DIR_INSTALL) iu URL="https://download3.operacdn.com/pub/opera/desktop/62.0.3331.99/linux/opera-stable_62.0.3331.99_amd64.deb" FILE="~/tmp/opera.deb"

opera-LINUX-neon:
	echo $(NOT_IMPLEMENTED_LINUX)

opera-OSX-opera:
	make --directory=$(DIR_INSTALL) i PACKAGE=opera BREW_SOURCE=cask

opera-OSX-neon:
	make --directory=$(DIR_INSTALL) i PACKAGE=opera-neon BREW_SOURCE=cask

opera-WIN32-opera:
	make --directory=$(DIR_INSTALL) iu URL="http://get.geo.opera.com/.private/OperaNeonSetup.exe?utm_tryagain=yes" FILE="~/tmp/opera.exe"

opera-WIN32-neon:
	make --directory=$(DIR_INSTALL) iu URL="https://net.geo.opera.com/opera/stable/windows?http_referrer=missing_via_opera_com&utm_source=(direct)_via_opera_com&utm_medium=doc&utm_campaign=(direct)_via_opera_com_https&utm_lastpage=opera.com/&utm_tryagain=yes" FILE="~/tmp/opera.exe"


vivaldi: vivaldi-$(OSFLAG) ## Install Vivaldi Browser

vivaldi-LINUX: vivaldi-$(OSID)

vivaldi-ubuntu: vivaldi-debian

vivaldi-debian:
	make --directory=$(DIR_INSTALL) iu URL="https://downloads.vivaldi.com/stable/vivaldi-stable_2.6.1566.49-1_amd64.deb" FILE="~/tmp/vivaldi.deb"
	
vivaldi-OSX:
	make --directory=$(DIR_INSTALL) i PACKAGE=vivaldi BREW_SOURCE=cask

vivaldi-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://downloads.vivaldi.com/stable/Vivaldi.2.6.1566.49.exe" FILE="~/tmp/vivaldi.exe"
