include ./Makefile.template

all-minimal: gimp ## Install gimp

all: all-minimal ## Install all-minimal

clb: all-minimal ## Install Rest tools used @ CLB 


gimp: gimp-$(OSFLAG) ## gimp

gimp-LINUX:
	apt install -y gimp

gimp-OSX:
	echo $(NOT_IMPLEMENTED_OSX)
	
gimp-WIN32:
	echo $(NOT_IMPLEMENTED_WINDOWS)


kdenlive: kdenlive-$(OSFLAG) ## kdenlive

kdenlive-LINUX:
	apt install -y kdenlive kdenlive-data

kdenlive-OSX:
	echo $(NOT_IMPLEMENTED_OSX)
	
kdenlive-WIN32:
	echo $(NOT_IMPLEMENTED_WINDOWS)


# postman: postman-$(OSFLAG) ## Postman

# postman-LINUX:
# 	snap install postman

# postman-OSX:
# 	echo $(NOT_IMPLEMENTED_OSX)
	
# postman-WIN32:
# 	echo $(NOT_IMPLEMENTED_WINDOWS)


# taurus: taurus-$(OSFLAG) ## Taurusc

# taurus-LINUX:
# 	echo $(NOT_IMPLEMENTED_LINUX)

# taurus-OSX:
# 	echo $(NOT_IMPLEMENTED_OSX)
	
# taurus-WIN32:
# 	echo $(NOT_IMPLEMENTED_WINDOWS)