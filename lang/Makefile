include ../Makefile.template

#
# ENV
#

DIR_INSTALL = ../.install

# #
# # Actual Action Definitions
# #

# GO_VERSION = 1.14.2

# golang: golang-$(OSFLAG) ## Install golang
# 	export GOPATH="$$HOME/go"
# 	# Go Critic (VS Code Required)
# 	go get -v github.com/go-lintpack/lintpack/...
# 	go get -v github.com/go-critic/go-critic/...
# 	# Go Doc (VS Code Required)
# 	# go get -v github.com/zmb3/gogetdoc/...
# 	# Go Outliner (VS Code Required)
# 	go get -u github.com/766b/go-outliner

# # golang-LINUX:
# # 	make --directory=$(DIR_INSTALL) dld URL="https://dl.google.com/go/go$(GO_VERSION).linux-amd64.tar.gz" FILE="~/tmp/go-lang.tar.gz"
# # 	cd ~/tmp && tar -xzf go-lang.tar.gz && sudo mv go /usr/local
# # 	sudo rm -rf /usr/local/bin/go /usr/local/bin/gofmt
# # 	sudo ln -s /usr/local/go/bin/go /usr/local/bin/go
# # 	sudo ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt

# # golang-OSX:
# # 	make --directory=$(DIR_INSTALL) iu URL="https://dl.google.com/go/go$(GO_VERSION).darwin-amd64.pkg" FILE="~/tmp/go-lang.pkg"

# golang-WIN32:
# 	make --directory=$(DIR_INSTALL) dld URL="https://dl.google.com/go/go$(GO_VERSION).windows-amd64.msi" FILE="$$$$HOME\Downloads\go-lang.msi"
# 	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/go-lang.msi"


# JAVA_VERSION=8
# JAVA_VERSION=9
# JAVA_VERSION=10
# JAVA_VERSION=11
# JAVA_VERSION=12
# JAVA_VERSION=13
# JAVA_VERSION=14
JAVA_VERSION=15
JAVA_TYPE=open
# JAVA_TYPE=oracle
JAVA_FOLDER=/opt/java
java: java-$(OSFLAG) ## Install Java JAVA_VERSION=15,8,9,10,11,12,13,14 JAVA_TYPE=open,oracle JAVA_FOLDER=/opt/java

java-LINUX: pre-java-LINUX java-$(JAVA_TYPE)-LINUX

java-open-LINUX:
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://jdk.java.net/archive" PACKAGE_MATCH="openjdk.\\+$(JAVA_VERSION).\\+linux.\\+.tar.gz" PACKAGE_DESTINATION="$(JAVA_FOLDER)"

java-oracle-LINUX:
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.oracle.com/java/technologies/javase-jdk$(JAVA_VERSION)-downloads.html" PACKAGE_MATCH="jdk.\\+$(JAVA_VERSION).\\+linux.\\+.tar.gz" PACKAGE_DESTINATION="$(JAVA_FOLDER)"

pre-java-LINUX:
	sudo mkdir -p $(JAVA_FOLDER)

# TODO: windows and mac


# NODE_VERSION=12.16.3
# nodejs: nodejs-$(OSFLAG) ## Install NodeJs NODE_VERSION=13,12,11,10,8

# # nodejs-LINUX:
# # ifeq ($(OSID),debian)
# # 	curl -sL https://deb.nodesource.com/setup_$(NODE_VERSION).x | bash -
# # 	sudo apt-get install -y nodejs
# # endif
# # ifeq ($(OSID),ubuntu)
# # 	curl -sL https://deb.nodesource.com/setup_$(NODE_VERSION).x | sudo -E bash -
# # 	sudo apt-get install -y nodejs
# # endif
# # ifeq ($(OSID),rhel)
# # 	curl -sL https://rpm.nodesource.com/setup_$(NODE_VERSION).x | sudo bash -
# # endif

# # nodejs-OSX:
# # 	@echo $(NOT_IMPLEMENTED_OSX)

# nodejs-WIN32:
# 	make --directory=$(DIR_INSTALL) dld URL="https://nodejs.org/dist/v$(NODE_VERSION)/node-v$(NODE_VERSION)-x64.msi" FILE="$$$$HOME\Downloads\node.msi"
# 	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/node.msi"


# PYTHON_VERSION = 3.8.3 # TODO: Might need treatment depending OS
# python: python-$(OSFLAG) ## Install Python

# python-LINUX:
# 	@echo $(NOT_IMPLEMENTED_LINUX)

# python-OSX:
# 	@echo $(NOT_IMPLEMENTED_OSX)

# python-WIN32:
# 	@echo make --directory=$(DIR_INSTALL) dld URL="https://www.python.org/ftp/python/$(PYTHON_VERSION)/python-$(PYTHON_VERSION).amd64.msi" FILE="$$$$HOME\Downloads\python.msi"
# 	@echo make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/python.msi"
# 	make --directory=$(DIR_INSTALL) dld URL="https://www.python.org/ftp/python/$(PYTHON_VERSION)/python-$(PYTHON_VERSION)rc1-amd64.exe" FILE="$$$$HOME\Downloads\python.exe"
# 	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/python.exe" PACKAGE_ARGS="/passive PrependPath=1 InstallAllUsers=1"


# RUBY_VERSION = 2.7.1-1
# ruby: ruby-$(OSFLAG) ## Install Ruby

# ruby-LINUX:
# 	@echo $(NOT_IMPLEMENTED_LINUX)

# ruby-OSX:
# 	@echo $(NOT_IMPLEMENTED_OSX)

# ruby-WIN32:
# 	make --directory=$(DIR_INSTALL) dld URL="https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-$(RUBY_VERSION)/rubyinstaller-$(RUBY_VERSION)-x64.exe" FILE="$$$$HOME\Downloads\ruby.exe"
# 	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/ruby.exe" PACKAGE_ARGS="/SP- /VERYSILENT /SUPPRESSMSGBOXES /NOCANCEL /NORESTART"
