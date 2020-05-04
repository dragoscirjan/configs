include ./Makefile.template

#
# Actual Action Definitions
#

DIR_INSTALL = ../.install

# CURL=curl -SL
# # INTELLIJ_APP=CL # CLion
# # INTELLIJ_APP=IIC # Idea CE
# # INTELLIJ_APP=IIU # Idea
# # INTELLIJ_APP=GO # GoLand
# # INTELLIJ_APP=PS # PhpStorm
# # INTELLIJ_APP=PCC # PyCharm CE
# # INTELLIJ_APP=PCP # PyCharm
# # INTELLIJ_APP=RM # RubyMine
# # INTELLIJ_APP=WS # WebStorm
# INTELLIJ_APP=
# INTELLIJ_OS=linux
# INTELLIJ_UTIL=intellij
# # INTELLIJ_UTIL=snap
# JQ=jq
# TIMESTAMP_SECCONDS=$(shell date +%s)

# # ifeq (LINUX,$(OSFLAG))
# # 	@echo "$(NOT_IMPLEMENTED_LINUX)"
# # endif
# ifeq (OSX,$(OSFLAG))
# 	INTELLIJ_OS=mac
# endif
# ifeq (WIN32,$(OSFLAG))
# 	INTELLIJ_OS=windows
# 	JQ=../bin/jq.exe
# 	TIMESTAMP_SECCONDS=$(shell powershell "(New-TimeSpan -Start (Get-Date \"01/01/1970\") -End (Get-Date)).TotalSeconds")
# endif
# ifeq (powershell,$(SHELL_IS))
# 	CURL=powershell -ExecutionPolicy ByPass -File ../.ps/curl.ps1 --url
# endif

# utils-LINUX:
# 	make --directory=$(DIR_INSTALL) i PACKAGE=jq

# utils-OSX:
# 	make --directory=$(DIR_INSTALL) i PACKAGE=jq

# utils-WIN32:
# 	make --directory=$(DIR_INSTALL) dld URL="https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe" FILE="../bin/jq.exe"


# all-minimal: vscode sublime ## Install Visual Studio Code & Sublime Text

# all: all-minimal idea pycharm-ce ## Install `all-minimal`, IntelliJ Idea & PyCharm CE

# intellij: utils-$(OSFLAG) intellij-$(OSFLAG)

# intellij-LINUX:
# 	curl -sSL "https://data.services.jetbrains.com/products/releases?code=$(INTELLIJ_APP)&latest=true&type=release&build=&_=$(TIMESTAMP_SECCONDS)" \
# 		| jq -r 'keys[] as $$k | .[$$k] | .[0] | .downloads.$(INTELLIJ_OS).link' \
# 		| while read link; do \
# 			echo $$link; \
# 			make --directory=$(DIR_INSTALL) dld URL="$$link" FILE="~/tmp/$${link##*/}"; \
# 			tar -xzvf ~/tmp/$${link##*/} -C ~/bin; \
# 			make --directory=$(DIR_INSTALL) rm FILE="~/tmp/$${link##*/}"; \
# 		done

# intellij-OSX:
# 	curl -sSL "https://data.services.jetbrains.com/products/releases?code=$(INTELLIJ_APP)&latest=true&type=release&build=&_=$(TIMESTAMP_SECCONDS)" \
# 		| jq -r 'keys[] as $$k | .[$$k] | .[0] | .downloads.$(INTELLIJ_OS).link' \
# 		| while read link; do \
# 			echo $$link; \
# 			make --directory=$(DIR_INSTALL) dld URL="$$link" FILE="~/tmp/$${link##*/}"; \
# 			make --directory=$(DIR_INSTALL) il FILE="~/tmp/$${link##*/}"; \
# 			make --directory=$(DIR_INSTALL) rm FILE="~/tmp/$${link##*/}"; \
# 		done

# intellij-WIN32:
# 	$(POWERSHELL) -File ./intellij.ps1 --keys $(INTELLIJ_APP) --url "https://data.services.jetbrains.com/products/releases?code=$(INTELLIJ_APP)&latest=true&type=release&build=&_=$(TIMESTAMP_SECCONDS)"


ATOM=stable
# ATOM=beta
atom: atom-$(OSFLAG) ## Install Atom ATOM=stable,beta

# atom-LINUX: atom-$(OSID)

# atom-ubuntu: atom-debian

# atom-debian: atom-debian-$(ATOM)

# atom-debian-stable:
# 	bash ../bin/install.sh --generic-url="https://atom.io/download/deb" --generic-match="atom-amd64.deb" --package-type=deb

# atom-debian-beta:
# 	bash ../bin/install.sh --generic-url="https://atom.io/download/deb?channel=beta" --generic-match="atom-amd64.deb" --package-type=deb

# atom-OSX:
# 	bash ../bin/install.sh --package=atom$$(test "$(ATOM)" == "beta" && echo "-beta") --package-type=dmg --package-repo=cask

atom-WIN32:
ifeq (beta,$(ATOM))
	make --directory=$(DIR_INSTALL) dld URL="https://atom.io/download/windows_x64?channel=beta" FILE="~/Downloads/atom-beta.exe"
	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/atom-beta.exe"
else
	make --directory=$(DIR_INSTALL) dld URL=https://atom.io/download/windows_x64 FILE="~/Downloads/atom.exe"
	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/atom.exe"
endif


# idea: idea-$(INTELLIJ_UTIL) ## Install IntelliJ IDEA

# idea-intellij:
# 	make intellij INTELLIJ_APP=IIU

# idea-snap:
# 	snap install intellij-idea-ultimate --classic


# idea-ce: idea-ce-$(INTELLIJ_UTIL) ## Install IntelliJ IDEA CE

# idea-ce-intellij:
# 	make intellij INTELLIJ_APP=IIC

# idea-ce-snap:
# 	snap install intellij-idea-community --classic

# NEO_CONFIG_PATH=~/.config/nvm
# ifeq ($(OSFLAG),WIN32)
# 	NEO_CONFIG_PATH=~/AppData/Local/nvim
# endif

# neovim: vim-$(OSFLAG) ## Install NeoVIM

# neovim-font:
# 	make --directory=../fonts nerd

# nevim-postinstall:
# 	# config
# 	mkdir -p $(NEO_CONFIG_PATH)
# 	cp -rdf $(NEO_CONFIG_PATH)/init.vim $(NEO_CONFIG_PATH)/init.vim-$$(date +%F).$$(date +%N) || true
# 	cp -rdf neovim-init.vim $(NEO_CONFIG_PATH)/init.vim
# 	# vim-plug
# 	curl --insecure -fLo $(NEO_CONFIG_PATH)/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# neovim-LINUX: neovim-font
# 	make --directory=$(DIR_INSTALL) i PACKAGE=neovim
# 	make --directory=$(DIR_INSTALL) i PACKAGE=python-neovim
# 	make --directory=$(DIR_INSTALL) i PACKAGE=python3-neovim
# 	make neovim-postinstall

# neovim-OSX: neovim-font
# 	echo $(NOT_IMPLEMENTED_OSX)

# neovim-WINDOWS: neovim-font
# 	echo $(NOT_IMPLEMENTED_WINDOWS)
# 	make neovim-postinstall
# 	sed -e "s|~/.local/share|~/AppData/Local|g" -i ~/AppData/Local/nvim/init.vim

# phpstorm: phpstorm-$(INTELLIJ_UTIL) ## Install IntelliJ PhpStorm

# phpstorm-intellij:
# 	make intellij INTELLIJ_APP=PS

# phpstorm-snap:
# 	snap install phpstorm --classic


# pycharm: pycharm-$(INTELLIJ_UTIL) ## Install IntelliJ PyCharm

# pycharm-intellij:
# 	make intellij INTELLIJ_APP=PCP

# pycharm-snap:
# 	snap install pycharm-professional --classic


# pycharm-ce: pycharm-ce-$(INTELLIJ_UTIL) ## Install IntelliJ PyCharm CE

# pycharm-ce-intellij:
# 	make intellij INTELLIJ_APP=PCC

# pycharm-ce-snap:
# 	snap install pycharm-community --classic


# webstorm: phpstorm-$(INTELLIJ_UTIL) ## Install IntelliJ WebStorm

# webstorm-intellij:
# 	make intellij INTELLIJ_APP=WS

# webstorm-snap:
# 	snap install phpstorm --classic


sublime: sublime-$(OSFLAG) ## Install Sublime Text

# sublime-LINUX: sublime-$(OSID)

# sublime-ubuntu: sublime-debian

# sublime-debian:
# 	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
# 	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
# 	bash ../bin/install.sh --package=sublime-text --package-type=deb

# sublime-centos: sublime-redhat

# sublime-redhat:
# 	sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
# 	sudo yum-config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
# 	sudo yum install sublime-text

# sublime-fedora:
# 	sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
# 	sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
# 	sudo dnf install sublime-text

# sublime-OSX:
# 	bash ../bin/install.sh --package=sublime-text --package-type=dmg --package-repo=cask

sublime-WIN32:
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.sublimetext.com/3" PACKAGE_MATCH="Sublime.*Setup" PACKAGE_ARGS="/SP- /VERYSILENT /NORESTART"


vim: vim-$(OSFLAG) ## Install VIM

# vim-font:
# 	make --directory=../fonts nerd

# vim-postinstall:
# 	# config
# 	cp ~/.vimrc ~/.vimrc-$$(date +%F).$$(date +%N) || true
# 	cp .vimrc ~/.vimrc
# 	# vim-plug
# 	curl --insecure -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# vim-LINUX: vim-font
# 	make --directory=$(DIR_INSTALL) i PACKAGE=vim
# 	make vim-postinstall

# vim-OSX: vim-font
# 	make vim-postinstall

vim-WIN32:
	@$(POWERSHELL) -Command "Write-Host -ForegroundColor Red '$(NOT_IMPLEMENTED_WINDOWS). Not supported.'"
	@exit 1


VSCODE=stable
# VSCODE=insider
vscode: vscode-$(OSFLAG) ## Install Visual Studio Code VSCODE=stable,insider

# vscode-LINUX: vscode-$(OSID)

# vscode-ubuntu: vscode-debian

# vscode-debian:
# 	bash ../bin/install.sh --download-url="https://update.code.visualstudio.com/latest/linux-deb-x64/$(VSCODE)" --package-type=deb

# # vscode-centos: vscode-redhat
# # vscode-fedora: vscode-redhat

# # vscode-redhat:
# # 	make --directory=$(DIR_INSTALL) iu URL="https://update.code.visualstudio.com/latest/linux-deb-x64/$(VSCODE)" FILE="~/tmp/vscode.deb"

# vscode-OSX:
# 	make --directory=$(DIR_INSTALL) i PACKAGE=visual-studio-code$$(test "$(VSCODE)" == "insider" && echo "-insiders") BREW_SOURCE=cask

vscode-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://update.code.visualstudio.com/latest/win32-x64/$(VSCODE)" FILE="~/Downloads/vscode-$(VSCODE).exe"
	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/vscode-$(VSCODE).exe" PACKAGE_ARGS="/SP- /VERYSILENT /NORESTART"
