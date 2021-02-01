include ../Makefile.template
#
# ENV
#

DIR_INSTALL = ../.install

# PROFILE_FILE = ~/.profile
PROFILE_FILE = ~/.bashrc

#
# Actual Action Definitions
#

#
# .NET
#

dotnet: php-$(OSFLAG) ## Install Ruby

dotnet-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

dotnet-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

dotnet-WIN32:
	@echo $(NOT_IMPLEMENTED_WINDOWS)

#
# GoLang
#

GO_VERSION = 1.15
# GO_VERSION = 1.14
# GO_VERSION = 1.13
# GO_VERSION = 1.12

GO_URL = https://golang.org/dl/

GO_FOLDER = /usr/local/go

golang: golang-$(OSFLAG) ## Install golang GO_VERSION=1.15,1.12,1.13,1.14
	export GOPATH="$$HOME/go"
	# Go Critic (VS Code Required)
	go get -v github.com/go-lintpack/lintpack/...
	go get -v github.com/go-critic/go-critic/...
	# Go Doc (VS Code Required)
	# go get -v github.com/zmb3/gogetdoc/...
	# Go Outliner (VS Code Required)
	go get -u github.com/766b/go-outliner

golang-LINUX: req_root_not golang-LINUX-debian
	rm -rf /tmp/go-lang.tar.gz
	curl -sSL "https://golang.org$$(curl -sSL $(GO_URL) | grep $(GO_VERSION) | grep linux-amd64.tar.gz | head -n1 | awk -F'"' '{ print $$4 == "download" ? $$6 : $$4; }')" --output "/tmp/go-lang.tar.gz"
	sudo rm -rf $(GO_FOLDER)
	cd /tmp \
		&& tar -xzf go-lang.tar.gz \
		&& rm /tmp/go-lang.tar.gz \
		&& sudo mv go /usr/local
	sudo rm -rf /usr/local/bin/go /usr/local/bin/gofmt
	sudo ln -s $(GO_FOLDER)/bin/go /usr/local/bin/go
	sudo ln -s $(GO_FOLDER)/bin/gofmt /usr/local/bin/gofmt
	cat $(PROFILE_FILE) | grep "prepare_go" || cat .profile.go >> $(PROFILE_FILE)
	bash -c "source $(PROFILE_FILE) && go version"

golang-LINUX-ubuntu: golang-LINUX-debian

golang-LINUX-debian:
	sudo apt-get update
	sudo apt-get install -y build-essential make

# 	make --directory=$(DIR_INSTALL) iu URL="https://dl.google.com/go/go$(GO_VERSION).darwin-amd64.pkg" FILE="~/tmp/go-lang.pkg"
golang-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

# 	make --directory=$(DIR_INSTALL) dld URL="https://dl.google.com/go/go$(GO_VERSION).windows-amd64.msi" FILE="$$$$HOME\Downloads\go-lang.msi"
# 	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/go-lang.msi"
golang-WIN32:
	@echo $(NOT_IMPLEMENTED_WINDOWS)


golang-add: golang-add-$(OSFLAG) ## Add golang GO_VERSION=1.15,1.12,1.13,1.14

golang-add-LINUX: golang-add-OSX

golang-add-OSX:
	VERSION=$$(curl $(GO_URL) | grep $(GO_VERSION) | grep linux-amd64.tar.gz | head -n1 | awk -F'go' '{ print $$2 }' | awk -F'.' '{ print $$1"."$$2"."$$3 }'); \
	echo "Installing go$$VERSION"; \
	go get golang.org/dl/go$$VERSION; \
	bash -c "source $(PROFILE_FILE); go$$VERSION download; go$$VERSION version"

golang-add-WIN32:
	@echo $(NOT_IMPLEMENTED_WINDOWS)

#
# Java
#

JAVA_VERSION=15
# JAVA_VERSION=14
# JAVA_VERSION=13
# JAVA_VERSION=12
# JAVA_VERSION=11
# JAVA_VERSION=10
# JAVA_VERSION=9
# JAVA_VERSION=8

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

java-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

java-WIN32:
	@echo $(NOT_IMPLEMENTED_WINDOWS)

# TODO: windows and mac


NODE_VERSION=12
nodejs: nodejs-$(OSFLAG) ## Install NodeJs NODE_VERSION=12,15,14,13,11

nodejs-LINUX:
ifeq ($(OSID),debian)
	curl -sL https://deb.nodesource.com/setup_$(NODE_VERSION).x | bash -
	sudo apt-get install -y nodejs
endif
ifeq ($(OSID),ubuntu)
	curl -sL https://deb.nodesource.com/setup_$(NODE_VERSION).x | sudo -E bash -
	sudo apt-get install -y nodejs
endif
ifeq ($(OSID),rhel)
	curl -sL https://rpm.nodesource.com/setup_$(NODE_VERSION).x | sudo bash -
endif

nodejs-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

# 	make --directory=$(DIR_INSTALL) dld URL="https://nodejs.org/dist/v$(NODE_VERSION)/node-v$(NODE_VERSION)-x64.msi" FILE="$$$$HOME\Downloads\node.msi"
# 	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/node.msi"
nodejs-WIN32:
	@echo $(NOT_IMPLEMENTED_WINDOWS)

#
# NodeJs with NVM
#

nodejs-nvm: nodejs-nvm-$(OSFLAG) ## Install NodeJs using (https://nvm.sh) NODE_VERSION=12,15,14,13,11

nodejs-nvm-LINUX:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
	cat $(PROFILE_FILE) | grep "HOME/.nvm" || cat .profile.nvm >> $(PROFILE_FILE)
	make nodejs-nvm-add

nodejs-nvm-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

nodejs-nvm-WIN32:
	@echo $(NOT_IMPLEMENTED_WINDOWS)

nodejs-nvm-add: nodejs-nvm-add-$(OSFLAG) ## Nodejs (nvm) add version NODE_VERSION=12,15,14,13,11

nodejs-nvm-add-LINUX: nodejs-nvm-add-OSX

nodejs-nvm-add-OSX:
	bash -c "source $(PROFILE_FILE) && nvm install $(NODE_VERSION)"

#
# Python
#

PY_VERSION = 3.9
# PY_VERSION = 3.8
# PY_VERSION = 3.7
# PY_VERSION = 3.6
# PY_VERSION = 3.5

# PY_CONFIGURE_OPTS = --enable-optimizations
PY_CONFIGURE_OPTS =

PY_FOLDER = /opt/python

PY_URL = https://www.python.org/ftp/python

python: python-$(OSFLAG) ## Install Python PY_VERSION=3.9,3.5,3.6,3.7,3.8

python-LINUX: req_root python-LINUX-$(OSID)
	curl https://bootstrap.pypa.io/get-pip.py | $(PY_FOLDER)/Python-$(PY_VERSION)/python

python-LINUX-ubuntu: python-LINUX-debian

python-LINUX-debian:
	apt-get install -y build-essential checkinstall
	apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev

	mkdir -p /opt/python
	VERSION=$$(curl -sSL $(PY_URL) | grep $(PY_VERSION) | awk -F '"' '{ print $$2 }' | awk -F'/' '{ print $$1 }' | sort -nr | head -n1); \
		cd $(PY_FOLDER); \
		\
		rm -rf Python-$$VERSION*; \
		curl -sSL "$(PY_URL)/$$VERSION/Python-$$VERSION.tgz" --output "$(PY_FOLDER)/Python-$$VERSION.tgz"; \
		tar -xzf Python-$$VERSION.tgz; \
		\
		cd Python-$$VERSION; \
		./configure $(PY_CONFIGURE_OPTS); \
		make; \
		cd ..; \
		\
		rm -rf Python-$(PY_VERSION); \
		ln -s Python-$$VERSION Python-$(PY_VERSION); \
		\
		rm -rf /usr/local/bin/python-c$(PY_VERSION); \
		ln -s $(PY_FOLDER)/Python-$(PY_VERSION)/python /usr/local/bin/python-c$(PY_VERSION)

python-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

# 	@echo make --directory=$(DIR_INSTALL) dld URL="https://www.python.org/ftp/python/$(PY_VERSION)/python-$(PY_VERSION).amd64.msi" FILE="$$$$HOME\Downloads\python.msi"
# 	@echo make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/python.msi"
# 	make --directory=$(DIR_INSTALL) dld URL="https://www.python.org/ftp/python/$(PY_VERSION)/python-$(PY_VERSION)rc1-amd64.exe" FILE="$$$$HOME\Downloads\python.exe"
# 	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/python.exe" PACKAGE_ARGS="/passive PrependPath=1 InstallAllUsers=1"
python-WIN32:
	@echo $(NOT_IMPLEMENTED_WINDOWS)

#
# Php
#

php: php-$(OSFLAG) ## Install Ruby

php-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

php-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

php-WIN32:
	@echo $(NOT_IMPLEMENTED_WINDOWS)


#
# Ruby
#

RUBY_VERSION = 2.7.1-1
ruby: ruby-$(OSFLAG) ## Install Ruby

ruby-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

ruby-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

# 	make --directory=$(DIR_INSTALL) dld URL="https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-$(RUBY_VERSION)/rubyinstaller-$(RUBY_VERSION)-x64.exe" FILE="$$$$HOME\Downloads\ruby.exe"
# 	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/ruby.exe" PACKAGE_ARGS="/SP- /VERYSILENT /SUPPRESSMSGBOXES /NOCANCEL /NORESTART"
ruby-WIN32:
	@echo $(NOT_IMPLEMENTED_WINDOWS)
