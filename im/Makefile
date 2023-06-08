include ../Makefile.template

default: ## Install default Instant Messengers (Discord, Ferdium, Slack)
	make discord
	make ferdium
	make slack
# 	make teams

# --------------------------------------------------------------------------------------


discord: APP_NAME=discord
discord: app-$(OSFLAG) ## Install Discord


ferdium: APP_NAME=ferdium
ferdium: app-$(OSFLAG) ## Install Ferdium


rocketchat: rocketchat-$(OSFLAG) ## Install Rocket Chat

rocketchat-LINUX: APP_NAME=rocketchat-desktop
rocketchat-LINUX: app-LINUX

rocketchat-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

rocketchat-WIN32: APP_NAME=rocketchat
rocketchat-WIN32: app-WIN32


slack: APP_NAME=slack
slack: app-$(OSFLAG) ## Install Slack

teams: teams-$(OSFLAG) ## Install Microsoft Teams

teams-LINUX: APP_NAME=teams-for-linux
teams-LINUX: app-LINUX

teams-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

teams-WIN32: APP_NAME=microsoft-teams
teams-WIN32: app-WIN32