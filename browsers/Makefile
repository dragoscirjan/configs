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

# --------------------------------------------------------------------------------------

brave: APP_NAME=brave ## Install Brave Browser https://brave.com/
brave: brave-$(OSFLAG)

brave-LINUX: app-LINUX

brave-OSX:  app-OSX

brave-WIN32: app-WIN32


chrome: chrome-$(OSFLAG) ## Install Google Chrome Browser

chrome-LINUX:
	@echo $(NOT_SUPPORTED_LINUX)

chrome-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

chrome-WIN32: APP_NAME=googlechrome
chrome-WIN32: app-WIN32


chromium: chromium-$(OSFLAG) ## Install Google Chrome Browser

chromium-LINUX: APP_NAME=chromium
chromium-LINUX: app-LINUX

chromium-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

chromium-WIN32: 
	@echo $(NOT_IMPLEMENTED_WIN32)


edge: edge-$(OSFLAG) ## Install Edge Browser EDGE=edge,insider

edge-LINUX: APP_NAME=test-edge-only APP_ARGS=--edge
edge-LINUX: app-LINUX

edge-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

edge-WIN32: APP_NAME=edge
edge-WIN32: app-WIN32


firefox: APP_NAME=firefox ## Install Firefox Browser https://www.mozilla.org/en-US/firefox/new/
firefox: firefox-$(OSFLAG)

firefox-LINUX: app-LINUX

firefox-OSX:  app-OSX

firefox-WIN32: app-WIN32


opera: APP_NAME=opera ## Install Firefox Browser https://www.mozilla.org/en-US/firefox/new/
opera: opera-$(OSFLAG)

opera-LINUX: app-LINUX

opera-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

opera-WIN32: app-WIN32


vivaldi: APP_NAME=vivaldi ## Install Firefox Browser https://www.mozilla.org/en-US/firefox/new/
vivaldi: vivaldi-$(OSFLAG)

vivaldi-LINUX:
	@echo $(NOT_SUPPORTED_LINUX)

vivaldi-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

vivaldi-WIN32: app-WIN32
