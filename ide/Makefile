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
	make --directory=$(DIR_INSTALL) i PACKAGE=jq

utils-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe" FILE="../bin/jq.exe"


all-minimal: vscode sublime ## Install Visual Studio Code & Sublime Text

all: all-minimal clion goland idea pycharm ## Install all-minimal, GoLand, Idea, PyCharm

clb: all-minimal clion goland idea pycharm ## Install IDEs used @ CLB 


clion: ## Install IntelliJ Clion
	make intellij INTELLIJ_APP=clion


intellij: utils-$(OSFLAG) intellij-$(OSFLAG)

intellij-LINUX:
	snap install --classic $(INTELLIJ_APP)

intellij-OSX:
	echo

intellij-WIN32:
	$(POWERSHELL) -File ./intellij.ps1 --keys $(INTELLIJ_APP) --url "https://data.services.jetbrains.com/products/releases?code=$(INTELLIJ_APP)&latest=true&type=release&build=&_=$(TIMESTAMP_SECCONDS)"


# ATOM=stable
# # ATOM=beta
# atom: atom-$(OSFLAG) ## Install Atom ATOM=stable,beta

# atom-LINUX: atom-$(OSID)

# atom-ubuntu: atom-debian

# atom-debian: atom-debian-$(ATOM)

# atom-debian-stable:
# 	bash ../bin/install.sh --generic-url="https://atom.io/download/deb" --generic-match="atom-amd64.deb" --package-type=deb

# atom-debian-beta:
# 	bash ../bin/install.sh --generic-url="https://atom.io/download/deb?channel=beta" --generic-match="atom-amd64.deb" --package-type=deb

# atom-OSX:
# 	bash ../bin/install.sh --package=atom$$(test "$(ATOM)" == "beta" && echo "-beta") --package-type=dmg --package-repo=cask

# atom-WIN32:
# ifeq (beta,$(ATOM))
# 	make --directory=$(DIR_INSTALL) iu URL="https://atom.io/download/windows_x64?channel=beta" FILE="~/tmp/atom-beta.exe"
# else
# 	make --directory=$(DIR_INSTALL) iu URL=https://atom.io/download/windows_x64 FILE="~/tmp/atom.exe"
# endif

goland: ## Install IntelliJ GoLand
	make intellij INTELLIJ_APP=goland


idea: ## Install IntelliJ IDEA
	make intellij INTELLIJ_APP=intellij-idea-ultimate


idea-ce: ## Install IntelliJ IDEA CE
	make intellij INTELLIJ_APP=intellij-idea-community


NEO_CONFIG_PATH=~/.config/nvm
ifeq ($(OSFLAG),WIN32)
	NEO_CONFIG_PATH=~/AppData/Local/nvim
endif

neovim: vim-$(OSFLAG) ## Install NeoVIM

neovim-font:
	make --directory=../fonts nerd

neovim-postinstall:
	# config
	mkdir -p $(NEO_CONFIG_PATH)
	cp -rdf $(NEO_CONFIG_PATH)/init.vim $(NEO_CONFIG_PATH)/init.vim-$$(date +%F).$$(date +%N) || true
	cp -rdf neovim-init.vim $(NEO_CONFIG_PATH)/init.vim
	# vim-plug
	curl --insecure -fLo $(NEO_CONFIG_PATH)/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

neovim-LINUX: neovim-font
	sudo snap install --classic --beta nvim
	make neovim-postinstall

neovim-OSX: neovim-font
	echo $(NOT_IMPLEMENTED_OSX)

neovim-WINDOWS: neovim-font
	echo $(NOT_IMPLEMENTED_WINDOWS)


phpstorm: ## Install IntelliJ PhpStorm
	make intellij INTELLIJ_APP=phpstorm


pycharm: ## Install IntelliJ PyCharm
	make intellij INTELLIJ_APP=pycharm-professional

pycharm-ce: ## Install IntelliJ PyCharm CE
	make intellij INTELLIJ_APP=pycharm-community


webstorm: ## Install IntelliJ WebStorm
	make intellij INTELLIJ_APP=webstorm


sublime: sublime-$(OSFLAG) ## Install Sublime Text

sublime-LINUX:
	snap install --classic sublime-text

sublime-OSX:
	bash ../bin/install.sh --package=sublime-text --package-type=dmg --package-repo=cask

# sublime-WIN32:
# 	make --directory=$(DIR_INSTALL) iu URL="https://download.sublimetext.com/Sublime%20Text%20Build%203207%20x64%20Setup.exe" FILE="~/tmp/sublime.exe"


vim: vim-$(OSFLAG) ## Install VIM

vim-font:
	make --directory=../fonts nerd

vim-postinstall:
	# config
	cp ~/.vimrc ~/.vimrc-$$(date +%F).$$(date +%N) || true
	cp .vimrc ~/.vimrc
	# vim-plug
	curl --insecure -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim-LINUX: vim-font
	make --directory=$(DIR_INSTALL) i PACKAGE=vim
	make vim-postinstall

vim-OSX: vim-font
	make vim-postinstall

vim-WINDOWS: vim-font
	make vim-postinstall


VSCODE=stable
# VSCODE=insider
vscode: vscode-$(OSFLAG) ## Install Visual Studio Code

vscode-LINUX: 
	snap install --classic code$$(test "$(VSCODE)" == "insider" && echo "-insiders")

vscode-OSX:
	make --directory=$(DIR_INSTALL) i PACKAGE=visual-studio-code$$(test "$(VSCODE)" == "insider" && echo "-insiders") BREW_SOURCE=cask

vscode-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://update.code.visualstudio.com/latest/win32-x64/$(VSCODE)" FILE="~/tmp/vscode.exe"
