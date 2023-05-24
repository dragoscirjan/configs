include ../Makefile.template

#
# Actual Action Definitions
#

POWERSHELL=powershell -ExecutionPolicy ByPass

DIR_INSTALL = ../.install

default: ## Install default browsers (without dev versions)
	make brave
	make chrome
	make firefox

BROWSER_NAME=
browser-LINUX:
	snap install $(BROWSER_NAME)

browser-OSX:
	brew install $(BROWSER_NAME)

browser-WIN32:
	choco upgrade -y $(BROWSER_NAME)

# --------------------------------------------------------------------------------------

brave: BROWSER_NAME=brave ## Install Brave Browser https://brave.com/
brave: brave-$(OSFLAG)

brave-LINUX: browser-LINUX

brave-OSX:  browser-OSX

brave-WIN32: browser-WIN32


chrome: chrome-$(OSFLAG) ## Install Google Chrome Browser

chrome-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

chrome-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

chrome-WIN32: BROWSER_NAME=googlechrome
chrome-WIN32: browser-WIN32


chromium: chromium-$(OSFLAG) ## Install Google Chrome Browser

chromium-LINUX: BROWSER_NAME=chromium
chromium-LINUX: browser-LINUX

chromium-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

chromium-WIN32: 
	@echo $(NOT_IMPLEMENTED_WIN32)


edge: edge-$(OSFLAG) ## Install Edge Browser EDGE=edge,insider

edge-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

edge-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

edge-WIN32: BROWSER_NAME=microsoft-edge
edge-WIN32: browser-WIN32


firefox: BROWSER_NAME=firefox ## Install Firefox Browser https://www.mozilla.org/en-US/firefox/new/
firefox: firefox-$(OSFLAG)

firefox-LINUX: browser-LINUX

firefox-OSX:  browser-OSX

firefox-WIN32: browser-WIN32


opera: BROWSER_NAME=opera ## Install Firefox Browser https://www.mozilla.org/en-US/firefox/new/
opera: opera-$(OSFLAG)

opera-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

opera-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

opera-WIN32: browser-WIN32


vivaldi: BROWSER_NAME=vivaldi ## Install Firefox Browser https://www.mozilla.org/en-US/firefox/new/
vivaldi: vivaldi-$(OSFLAG)

vivaldi-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

vivaldi-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

vivaldi-WIN32: browser-WIN32
