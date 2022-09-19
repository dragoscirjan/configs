include ./Makefile.template

all-minimal: flameshot ## Install flameshot

all: all-minimal ## Install all-minimal

clb: all-minimal ## Install Rest tools used @ CLB 


flameshot: flameshot-$(OSFLAG) ## flameshot

flameshot-LINUX:
	snap install flameshot

flameshot-OSX:
	echo $(NOT_IMPLEMENTED_OSX)
	
flameshot-WIN32:
	echo $(NOT_IMPLEMENTED_WINDOWS)