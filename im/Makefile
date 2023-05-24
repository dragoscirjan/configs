include ../Makefile.template

#
# Actual Action Definitions
#

POWERSHELL=powershell -ExecutionPolicy ByPass

DIR_INSTALL = ../.install

default: ## Install default Instant Messengers (Discord, Ferdium, Slack)
	make discord
	make ferdium
	make slack
# 	make teams

IM_NAME=
im-LINUX:
	snap install $(IM_NAME)

im-OSX:
	brew install $(IM_NAME)

im-WIN32:
	choco upgrade -y $(IM_NAME)

# --------------------------------------------------------------------------------------


discord: discord-$(OSFLAG) ## Install Discord
discord-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

discord-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

discord-WIN32: IM_NAME=discord
discord-WIN32: im-WIN32


ferdium: ferdium-$(OSFLAG) ## Install Ferdium
ferdium-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

ferdium-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

ferdium-WIN32: IM_NAME=ferdium
ferdium-WIN32: im-WIN32


rocketchat: rocketchat-$(OSFLAG) ## Install Rocket Chat

rocketchat-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

rocketchat-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

rocketchat-WIN32: IM_NAME=rocketchat
rocketchat-WIN32: im-WIN32


slack: slack-$(OSFLAG) ## Install Slack

slack-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

slack-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

slack-WIN32: IM_NAME=slack
slack-WIN32: im-WIN32


teams: teams-$(OSFLAG) ## Install Microsoft Teams

teams-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

teams-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

teams-WIN32: IM_NAME=microsoft-teams
teams-WIN32: im-WIN32