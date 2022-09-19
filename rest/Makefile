include ./Makefile.template

all-minimal: insomnia postman ## Install Insomnia & Postman

all: all-minimal jmeter ## Install all-minimal, JMeter and Taurus

clb: postman jmeter ## Install Rest tools used @ CLB 


insomnia: insomnia-$(OSFLAG) ## Insomnia

insomnia-LINUX:
	snap install insomnia

insomnia-OSX:
	echo $(NOT_IMPLEMENTED_OSX)
	
insomnia-WIN32:
	echo $(NOT_IMPLEMENTED_WINDOWS)


jmeter: jmeter-$(OSFLAG) ## JMeter

jmeter-LINUX:
	echo $(NOT_IMPLEMENTED_LINUX)

jmeter-OSX:
	echo $(NOT_IMPLEMENTED_OSX)
	
jmeter-WIN32:
	echo $(NOT_IMPLEMENTED_WINDOWS)


postman: postman-$(OSFLAG) ## Postman

postman-LINUX:
	snap install postman

postman-OSX:
	echo $(NOT_IMPLEMENTED_OSX)
	
postman-WIN32:
	echo $(NOT_IMPLEMENTED_WINDOWS)


taurus: taurus-$(OSFLAG) ## Taurusc

taurus-LINUX:
	echo $(NOT_IMPLEMENTED_LINUX)

taurus-OSX:
	echo $(NOT_IMPLEMENTED_OSX)
	
taurus-WIN32:
	echo $(NOT_IMPLEMENTED_WINDOWS)