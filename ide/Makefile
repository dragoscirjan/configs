include ./Makefile.template

#
# Actual Action Definitions
#

DIR_INSTALL = ../.install

CURL=curl -SL
# INTELLIJ_APP=CL # CLion
# INTELLIJ_APP=IIC # Idea CE
# INTELLIJ_APP=IIU # Idea
# INTELLIJ_APP=GO # GoLand
# INTELLIJ_APP=PS # PhpStorm
# INTELLIJ_APP=PCC # PyCharm CE
# INTELLIJ_APP=PCP # PyCharm
# INTELLIJ_APP=RM # RubyMine
# INTELLIJ_APP=WS # WebStorm
INTELLIJ_APP=
INTELLIJ_OS=linux
INTELLIJ_UTIL=intellij
# INTELLIJ_UTIL=snap
JQ=jq
TIMESTAMP_SECCONDS=$(shell date +%s)

# ifeq (LINUX,$(OSFLAG))
# 	@echo "$(NOT_IMPLEMENTED_LINUX)"
# endif
ifeq (OSX,$(OSFLAG))
	INTELLIJ_OS=mac
endif
ifeq (WIN32,$(OSFLAG))
	INTELLIJ_OS=windows
	JQ=../bin/jq.exe
	TIMESTAMP_SECCONDS=$(shell powershell "(New-TimeSpan -Start (Get-Date \"01/01/1970\") -End (Get-Date)).TotalSeconds")
endif
ifeq (powershell,$(SHELL_IS))
	CURL=powershell -ExecutionPolicy ByPass -File ../.ps/curl.ps1 --url
endif

utils-LINUX:
	make --directory=$(DIR_INSTALL) i PACKAGE=jq

utils-OSX:
	@echo Do I need JQ?

utils-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe" FILE="../bin/jq.exe"

intellij: utils-$(OSFLAG) intellij-$(OSFLAG)

intellij-LINUX:
	curl -sSL "https://data.services.jetbrains.com/products/releases?code=$(INTELLIJ_APP)&latest=true&type=release&build=&_=$(TIMESTAMP_SECCONDS)" \
		| jq -r 'keys[] as $$k | .[$$k] | .[0] | .downloads.$(INTELLIJ_OS).link' \
		| while read link; do \
			echo $$link; \
			make --directory=$(DIR_INSTALL) dld URL="$$link" FILE="~/tmp/$${link##*/}"; \
			tar -xzvf ~/tmp/$${link##*/} -C ~/bin; \
			make --directory=$(DIR_INSTALL) rm FILE="~/tmp/$${link##*/}"; \
		done

intellij-OSX:
	curl -sSL "https://data.services.jetbrains.com/products/releases?code=$(INTELLIJ_APP)&latest=true&type=release&build=&_=$(TIMESTAMP_SECCONDS)" \
		| jq -r 'keys[] as $$k | .[$$k] | .[0] | .downloads.$(INTELLIJ_OS).link' \
		| while read link; do \
			echo $$link; \
			make --directory=$(DIR_INSTALL) dld URL="$$link" FILE="~/tmp/$${link##*/}"; \
			make --directory=$(DIR_INSTALL) li PACKAGE="~/tmp/$${link##*/}"; \
			make --directory=$(DIR_INSTALL) rm FILE="~/tmp/$${link##*/}"; \
		done

intellij-WIN32:
	$(POWERSHELL) -File ./intellij.ps1 --keys $(INTELLIJ_APP) --url "https://data.services.jetbrains.com/products/releases?code=$(INTELLIJ_APP)&latest=true&type=release&build=&_=$(TIMESTAMP_SECCONDS)"


ATOM_MODE=stable
# ATOM_MODE=beta
atom: atom-$(OSFLAG) ## Install Atom

atom-LINUX: atom-$(OSID)

atom-ubuntu: atom-debian

atom-debian: atom-debian-$(ATOM_MODE)

atom-debian-stable: 
	make --directory=$(DIR_INSTALL) iu URL="https://atom-installer.github.com/v1.39.1/atom-amd64.deb?s=$(shell date +%s)&ext=.deb" FILE="~/tmp/atom.deb"

atom-debian-beta:
	make --directory=$(DIR_INSTALL) iu URL="https://atom-installer.github.com/v1.40.0-beta1/atom-amd64.deb?s=$(shell date +%s)&ext=.deb" FILE="~/tmp/atom.deb"

atom-OSX:
	make --directory=../.install i PACKAGE=atom$$(test "$(ATOM_MODE)" == "beta" && echo "-beta")

atom-WIN32:
ifeq (beta,$(ATOM_MODE))
	make --directory=$(DIR_INSTALL) iu URL="https://atom.io/download/windows_x64?channel=beta" FILE="~/tmp/atom-beta.exe"
else
	make --directory=$(DIR_INSTALL) iu URL=https://atom.io/download/windows_x64 FILE="~/tmp/atom.exe"
endif


idea: idea-$(INTELLIJ_UTIL) ## Install IntelliJ IDEA

idea-intellij:
	make intellij INTELLIJ_APP=IIU

idea-snap:
	snap install intellij-idea-ultimate --classic


idea-ce: idea-ce-$(INTELLIJ_UTIL) ## Install IntelliJ IDEA CE

idea-ce-intellij:
	make intellij INTELLIJ_APP=IIC

idea-ce-snap:
	snap install intellij-idea-community --classic


phpstorm: phpstorm-$(INTELLIJ_UTIL) ## Install IntelliJ PhpStorm

phpstorm-intellij:
	make intellij INTELLIJ_APP=PS

phpstorm-snap:
	snap install phpstorm --classic


pycharm: pycharm-$(INTELLIJ_UTIL) ## Install IntelliJ PyCharm

pycharm-intellij:
	make intellij INTELLIJ_APP=PCP

pycharm-snap:
	snap install pycharm-professional --classic


pycharm-ce: pycharm-ce-$(INTELLIJ_UTIL) ## Install IntelliJ PyCharm CE

pycharm-ce-intellij:
	make intellij INTELLIJ_APP=PCC

pycharm-ce-snap:
	snap install pycharm-community --classic


sublime: sublime-$(OSFLAG) ## Install Sublime Text

sublime-LINUX: sublime-$(OSID)

sublime-ubuntu: sublime-debian

sublime-debian:
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	make --directory=$(DIR_INSTALL) i PACKAGE=sublime-text

sublime-centos: sublime-redhat

sublime-redhat:
	sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
	sudo yum-config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
	sudo yum install sublime-text

sublime-fedora:
	sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
	sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
	sudo dnf install sublime-text

sublime-OSX:
	make --directory=$(DIR_INSTALL) i PACKAGE=sublime-text BREW_SOURCE=cask

sublime-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://download.sublimetext.com/Sublime%20Text%20Build%203207%20x64%20Setup.exe" FILE="~/tmp/sublime.exe"


VSCODE=stable
# VSCODE=insider
vscode: vscode-$(OSFLAG) ## Install Visual Studio Code

vscode-LINUX: vscode-$(OSID)

vscode-ubuntu: vscode-debian

vscode-debian:
	make --directory=$(DIR_INSTALL) iu URL="https://update.code.visualstudio.com/latest/linux-deb-x64/$(VSCODE)" FILE="~/tmp/vscode.deb"

# vscode-centos: vscode-redhat
# vscode-fedora: vscode-redhat

# vscode-redhat:
# 	make --directory=$(DIR_INSTALL) iu URL="https://update.code.visualstudio.com/latest/linux-deb-x64/$(VSCODE)" FILE="~/tmp/vscode.deb"

vscode-OSX:
	cd ../.install && make i PACKAGE=visual-studio-code

vscode-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://update.code.visualstudio.com/latest/win32-x64/$(VSCODE)" FILE="~/tmp/vscode.exe"
