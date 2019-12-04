include Makefile.template

#
# ENV
#

DIR_INSTALL = ../.install

#
# Actual Action Definitions
#

golang: golang-$(OSFLAG) ## Install golang

golang-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

golang-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

golang-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://dl.google.com/go/go1.12.7.windows-amd64.msi" FILE="~/tmp/go-lang.msi"

# JAVA_VERSION=8
JAVA_VERSION=11
JAVA_TYPE=open
# JAVA_TYPE=oracle
java: java-$(OSFLAG) ## Install Java

java-LINUX: java-$(OSID)
	make --directory=$(DIR_INSTALL) i PACKAGE=maven

java-ubuntu: java-debian
java-debian: java-debian-$(JAVA_TYPE)

java-debian-open:
	make --directory=$(DIR_INSTALL) i PACKAGE="openjdk-$(JAVA_VERSION)-jdk openjdk-$(JAVA_VERSION)-jre"

java-debian-oracle:
	sudo add-apt-repository ppa:webupd8team/java

java-OSX:

java-WIN32:


nodejs: nodejs-$(OSFLAG) ## Install NodeJs

nodejs-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

nodejs-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

nodejs-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://nodejs.org/dist/v10.16.1/node-v10.16.1-x64.msi" FILE="~/tmp/node.msi"


python: python-$(OSFLAG) ## Install Python

python-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

python-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

WIN_PY_VER = 3.7.5
python-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://www.python.org/ftp/python/$(WIN_PY_VER)/python-$(WIN_PY_VER).exe" FILE="~/tmp/python.exe" IL_WIN_ARGS="/NoCRLCheck /passive InstallAllUsers=1 PrependPath=1 Include_test=0"


ruby: ruby-$(OSFLAG) ## Install Ruby

ruby-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

ruby-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

ruby-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-2.6.3-1/rubyinstaller-2.6.3-1-x64.exe" FILE="~/tmp/ruby.exe IL_WIN_ARGS="/sp- /silent"