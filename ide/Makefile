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
# OSFLAG=intellij
# # OSFLAG=snap
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
# 	CURL=powershell -ExecutionPolicy ByPass -File ../.scripts/curl.ps1 --url
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


idea: idea-$(OSFLAG) ## Install JetBrains IntelliJ IDEA

idea-LINUX: req_root_not
	sudo snap install intellij-idea-ultimate --classic

idea-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://download.jetbrains.com/idea/silent.config" FILE="~/Downloads/silent.config"
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.jetbrains.com/idea/download/download-thanks.html?platform=windows" PACKAGE_MATCH="ideaIU.*exe" PACKAGE_ARGS="/S /CONFIG=__HOME__\Downloads\silent.config /D=__PROGRAMFILES__\JetBrains\IntelliJIDEA-Ultimate-Edition"

idea-ce: idea-ce-$(OSFLAG) ## Install JetBrains IntelliJ IDEA CE

idea-ce-LINUX: req_root_not
	sudo snap install intellij-idea-community --classic

idea-ce-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://download.jetbrains.com/idea/silent.config" FILE="~/Downloads/silent.config"
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.jetbrains.com/idea/download/download-thanks.html?platform=windows&code=IIC" PACKAGE_MATCH="ideaIC-2020.*exe" PACKAGE_ARGS="/S /CONFIG=__HOME__\Downloads\silent.config /D=__PROGRAMFILES__\JetBrains\IntelliJIDEA-Community-Edition"

goland: goland-$(OSFLAG) ## Install JetBrains GoLand

golang-LINUX: req_root_not
	sudo snap Install goland --classic

goland-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://download.jetbrains.com/go/silent.config" FILE="~/Downloads/silent.config"
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="goland-2020.1.1.exe" PACKAGE_MATCH="goland.*.exe" PACKAGE_ARGS="/S /CONFIG=__HOME__\Downloads\silent.config /D=__PROGRAMFILES__\JetBrains\GoLand"


NEO_CONFIG_PATH=~/.config/nvm
ifeq ($(OSFLAG),WIN32)
	NEO_CONFIG_PATH=$$HOME\AppData\Local\nvim
endif
neovim-postinstall:
	make --directory=$(DIR_INSTALL) mkdir MKDIR_PATH="$(NEO_CONFIG_PATH)"
ifeq ($(OSFLAG),WIN32)
	$(POWERSHELL) -Command 'Copy-Item "$(NEO_CONFIG_PATH)\init.vim" -Destination "$(NEO_CONFIG_PATH)\init-$$(get-date -f yyyyMMddHHmmss).vim"' -Force
	$(POWERSHELL) -Command 'Copy-Item ".\neovim-init.vim" -Destination "$(NEO_CONFIG_PATH)\init.vim"'
else
	cp $(NEO_CONFIG_PATH)/init.vim $(NEO_CONFIG_PATH)/init.vim-$$(date +%F).$$(date +%N)
	cp ./neovim-init.vim $(NEO_CONFIG_PATH)/init.vim
endif
	make --directory=$(DIR_INSTALL) dld URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" FILE="$$$(NEO_CONFIG_PATH)/autoload/plug.vim" CURL_OPTS="--create-dirs"

neovim: req_root neovim-$(OSFLAG) ## Install NeoVIM

neovim-WIN32:
	make --directory=$(DIR_INSTALL) i PACKAGE=neovim
	make neovim-postinstall
	# sed -e "s|~/.local/share|~/AppData/Local|g" -i $(NEO_CONFIG_PATH)/init.vim

phpstorm: phpstorm-$(OSFLAG) ## Install JetBrains PhpStorm

phpstorm-LINUX:
	sudo snap install phpstorm --classic

phpstorm-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://download.jetbrains.com/webide/silent.config"
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.jetbrains.com/phpstorm/download/download-thanks.html" PACKAGE_MATCH="PhpStorm.*.exe" PACKAGE_ARGS="/S /CONFIG=__HOME__\Downloads\silent.config /D=__PROGRAMFILES__\JetBrains\PhpStorm"


pycharm: pycharm-$(OSFLAG) ## Install JetBrains PyCharm

pycharm-LINUX:
	sudo snap install pycharm-professional --classic

pycharm-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://download.jetbrains.com/python/silent.config" FILE="~/Downloads/silent.config"
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.jetbrains.com/pycharm/download/download-thanks.html?platform=windows" PACKAGE_MATCH="pycharm-professional.*.exe" PACKAGE_ARGS="/S /CONFIG=__HOME__\Downloads\silent.config /D=__PROGRAMFILES__\JetBrains\PyCharm-Professional"


pycharm-ce: pycharm-ce-$(OSFLAG) ## Install JetBrains PyCharm CE

pycharm-ce-LINUX:
	sudo snap install pycharm-community --classic

# make --directory=$(DIR_INSTALL) dld URL="https://download.jetbrains.com/python/silent.config" FILE="~/Downloads/silent.config"
# make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.jetbrains.com/pycharm/download/download-thanks.html?platform=windows&code=PCC" PACKAGE_MATCH="pycharm-community.*.exe" PACKAGE_ARGS="/S /CONFIG=__HOME__\Downloads\silent.config /D=__PROGRAMFILES__\JetBrains\PyCharm-Community"
pycharm-ce-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://download.jetbrains.com/python/silent.config" FILE="__HOME__/Downloads/silent.config"
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.jetbrains.com/pycharm/download/" PACKAGE_MATCH="pycharm-community.*.exe" PACKAGE_ARGS="/S /CONFIG=__HOME__\Downloads\silent.config /D=__PROGRAMFILES__\JetBrains\PyCharm-Community"

sublime: sublime-$(OSFLAG) ## Install Sublime Text

sublime-WIN32:
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.sublimetext.com/3" PACKAGE_MATCH="Sublime.*Setup" PACKAGE_ARGS="/SP- /VERYSILENT /NORESTART"


vim: vim-$(OSFLAG) ## Install VIM

vim-WIN32:
	@$(POWERSHELL) -Command "Write-Host -ForegroundColor Red '$(NOT_IMPLEMENTED_WINDOWS). Not supported.'"
	@exit 1


VSCODE=stable
# VSCODE=insider
vscode: vscode-$(OSFLAG) ## Install Visual Studio Code VSCODE=stable,insider

vscode-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://update.code.visualstudio.com/latest/win32-x64/$(VSCODE)" FILE="~/Downloads/vscode-$(VSCODE).exe"
	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/vscode-$(VSCODE).exe" PACKAGE_ARGS="/SP- /VERYSILENT /NORESTART"


webstorm: webstorm-$(OSFLAG) ## Install JetBrains WebStorm

webstorm-LINUX:
	sudo snap install webstorm --classic

webstorm-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://download.jetbrains.com/webide/silent.config"
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.jetbrains.com/webstorm/download/download-thanks.html" PACKAGE_MATCH="WebStorm.*.exe" PACKAGE_ARGS="/S /CONFIG=__HOME__\Downloads\silent.config /D=__PROGRAMFILES__\JetBrains\WebStorm"
