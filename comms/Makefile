include ./Makefile.template

all-minimal: discord ferdium ## Install Discord & Ferdium

all: all-minimal slack ## Install all-minimal & Slack

clb: ferdium slack teams zoom ## Install Comms used @ CLB 


discord: discord-$(OSFLAG) ## Discord

discord-LINUX:
	snap install zoom-client

discord-OSX:
	echo $(NOT_IMPLEMENTED_OSX)
	
discord-WIN32:
	echo $(NOT_IMPLEMENTED_WINDOWS)


ferdium: ferdium-$(OSFLAG) ## Ferdium (Replacement for Franz)

ferdium-LINUX:
	snap install ferdium

ferdium-OSX:
	echo $(NOT_IMPLEMENTED_OSX)
	
ferdium-WIN32:
	echo $(NOT_IMPLEMENTED_WINDOWS)


slack: slack-$(OSFLAG) ## Slack

slack-LINUX:
	snap install slack

slack-OSX:
	echo $(NOT_IMPLEMENTED_OSX)
	
slack-WIN32:
	echo $(NOT_IMPLEMENTED_WINDOWS)


teams: teams-$(OSFLAG) ## Teams

teams-LINUX:
	snap install teams

teams-OSX:
	echo $(NOT_IMPLEMENTED_OSX)
	
teams-WIN32:
	echo $(NOT_IMPLEMENTED_WINDOWS)


zoom: zoom-$(OSFLAG) ## Zoom

zoom-LINUX:
	snap install zoom-client

zoom-OSX:
	echo $(NOT_IMPLEMENTED_OSX)
	
zoom-WIN32:
	echo $(NOT_IMPLEMENTED_WINDOWS)
