include ../Makefile.template

#
# Actual Action Definitions
#

POWERSHELL=powershell -ExecutionPolicy ByPass

DIR_INSTALL = ../.install

default: ## Install default IDEs (CLion, Fleet, GoLand, IntelliJ IDEA, PyCharm, Sublime Text, VSCode, VSCode Insiders)
	make clion
	make fleet
	make goland
	make idea
	make pycharm
	make sublime
	make vscode
	make vscode-insiders

IDE_NAME=
ide-LINUX:
	snap install $(IDE_NAME)

ide-OSX:
	brew install $(IDE_NAME)

ide-WIN32:
	choco upgrade -y $(IDE_NAME)

# --------------------------------------------------------------------------------------


clion: clion-$(OSFLAG) ## Install JetBrains CLion https://www.jetbrains.com/clion/

clion-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

clion-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

clion-WIN32: IDE_NAME=clion-ide
clion-WIN32: ide-WIN32


fleet: fleet-$(OSFLAG) ## Install JetBrains GoLand https://www.jetbrains.com/fleet/

fleet-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

fleet-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

fleet-WIN32: 
	@echo $(NOT_IMPLEMENTED_WIN32)


goland: goland-$(OSFLAG) ## Install JetBrains GoLand https://www.jetbrains.com/goland/

goland-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

goland-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

goland-WIN32: IDE_NAME=goland
goland-WIN32: ide-WIN32


idea: idea-$(OSFLAG) ## Install JetBrains IntelliJ IDEA https://www.jetbrains.com/idea/

idea-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

idea-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

idea-WIN32: IDE_NAME=intellijidea-ultimate
idea-WIN32: ide-WIN32


idea-community: idea-community-$(OSFLAG) ## Install JetBrains IntelliJ IDEA https://www.jetbrains.com/idea/

idea-community-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

idea-community-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

idea-community-WIN32: IDE_NAME=intellijidea-community
idea-community-WIN32: ide-WIN32


jetbrains-toolbox: jetbrains-toolbox-$(OSFLAG) ## Install JetBrains Toolbox https://www.jetbrains.com/toolbox-app/

jetbrains-toolbox-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

jetbrains-toolbox-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

jetbrains-toolbox-WIN32: IDE_NAME=intellijidea-community
jetbrains-toolbox-WIN32: ide-WIN32


phpstorm: phpstorm-$(OSFLAG) ## Install JetBrains GoLand https://www.jetbrains.com/phpstorm/

phpstorm-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

phpstorm-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

phpstorm-WIN32: IDE_NAME=phpstorm
phpstorm-WIN32: ide-WIN32


pycharm: pycharm-$(OSFLAG) ## Install JetBrains PyCharm https://www.jetbrains.com/pycharm/

pycharm-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

pycharm-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

pycharm-WIN32: IDE_NAME=pycharm-professional
pycharm-WIN32: ide-WIN32


pycharm-community: pycharm-community-$(OSFLAG) ## Install IntelliJ GoLand https://www.jetbrains.com/pycharm/

pycharm-community-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

pycharm-community-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

pycharm-community-WIN32: IDE_NAME=PyCharm-community
pycharm-community-WIN32: ide-WIN32


rider: rider-$(OSFLAG) ## Install JetBrains Rider https://www.jetbrains.com/rider/

rider-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

rider-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

rider-WIN32: IDE_NAME=jetbrains-rider
rider-WIN32: ide-WIN32


sublime: sublime-$(OSFLAG) ## Install Sublime Text https://www.sublimetext.com/

sublime-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

sublime-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

sublime-WIN32: IDE_NAME=sublimetext4
sublime-WIN32: ide-WIN32


visual-studio: visual-studio-$(OSFLAG) ## Install Visual Studio (Installer) https://visualstudio.microsoft.com/

visual-studio-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

visual-studio-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

visual-studio-WIN32: IDE_NAME=visualstudio-installer
visual-studio-WIN32: ide-WIN32


visual-studio-community: visual-studio-community-$(OSFLAG) ## Install Visual Studio (Installer) https://visualstudio.microsoft.com/

visual-studio-community-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

visual-studio-community-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

visual-studio-community-WIN32: IDE_NAME=visualstudio2022community
visual-studio-community-WIN32: ide-WIN32


vscode: vscode-$(OSFLAG) ## Install Visual Studio Code https://code.visualstudio.com/

vscode-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

vscode-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

vscode-WIN32: IDE_NAME=vscode
vscode-WIN32: ide-WIN32


vscode-insiders: vscode-insiders-$(OSFLAG) ## Install Visual Studio Code (Insiders) https://code.visualstudio.com/

vscode-insiders-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

vscode-insiders-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

vscode-insiders-WIN32: IDE_NAME=vscode-insiders
vscode-insiders-WIN32: ide-WIN32


webstorm: webstorm-$(OSFLAG) ## Install JetBrains WebStorm https://www.jetbrains.com/webstorm/

webstorm-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

webstorm-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

webstorm-WIN32: IDE_NAME=WebStorm
webstorm-WIN32: ide-WIN32



# include ../Makefile.template

# #
# # Actual Action Definitions
# #

# DIR_INSTALL = ../.install

# all-minimal: vscode sublime ## Install Visual Studio Code & Sublime Text

# all: all-minimal goland idea pycharm ## Install `all-minimal`, idea Idea & PyCharm CE

# ATOM=stable
# # ATOM=beta
# atom: atom-$(OSFLAG) ## Install Atom ATOM=stable,beta


# atom-WIN32:
# ifeq (beta,$(ATOM))
# 	make --directory=$(DIR_INSTALL) dld URL="https://atom.io/download/windows_x64?channel=beta" FILE="~/Downloads/atom-beta.exe"
# 	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/atom-beta.exe"
# else
# 	make --directory=$(DIR_INSTALL) dld URL=https://atom.io/download/windows_x64 FILE="~/Downloads/atom.exe"
# 	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/atom.exe"
# endif

# clion: ## Install JetBrains CLion
# 	make jetbrains JETBRAINS_IDE=clion

# IDEA=community
# # IDEA=educational
# # IDEA=ultimate
# idea: ## Install JetBrains Intellij IDEA IDEA=community|ultimate
# 	make jetbrains JETBRAINS_IDE=intellij-idea-$(IDEA)

# jetbrains: req_root_not jetbrains-$(OSFLAG)

# jetbrains-LINUX:
# 	sudo snap install $(JETBRAINS_IDE) --classic

# goland: ## Install JetBrains GoLand
# 	make jetbrains JETBRAINS_IDE=goland

# # goland-WIN32:
# # 	make --directory=$(DIR_INSTALL) dld URL="https://download.jetbrains.com/go/silent.config" FILE="~/Downloads/silent.config"
# # 	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="goland-2020.1.1.exe" PACKAGE_MATCH="goland.*.exe" PACKAGE_ARGS="/S /CONFIG=__HOME__\Downloads\silent.config /D=__PROGRAMFILES__\JetBrains\GoLand"


# NEO_CONFIG_PATH=~/.config/nvm
# ifeq ($(OSFLAG),WIN32)
# 	NEO_CONFIG_PATH=$$HOME\AppData\Local\nvim
# endif
# neovim-postinstall:
# 	make --directory=$(DIR_INSTALL) mkdir MKDIR_PATH="$(NEO_CONFIG_PATH)"
# ifeq ($(OSFLAG),WIN32)
# 	$(POWERSHELL) -Command 'Copy-Item "$(NEO_CONFIG_PATH)\init.vim" -Destination "$(NEO_CONFIG_PATH)\init-$$(get-date -f yyyyMMddHHmmss).vim"' -Force
# 	$(POWERSHELL) -Command 'Copy-Item ".\neovim-init.vim" -Destination "$(NEO_CONFIG_PATH)\init.vim"'
# else
# 	cp $(NEO_CONFIG_PATH)/init.vim $(NEO_CONFIG_PATH)/init.vim-$$(date +%F).$$(date +%N)
# 	cp ./neovim-init.vim $(NEO_CONFIG_PATH)/init.vim
# endif
# 	make --directory=$(DIR_INSTALL) dld URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" FILE="$$$(NEO_CONFIG_PATH)/autoload/plug.vim" CURL_OPTS="--create-dirs"

# neovim: req_root neovim-$(OSFLAG) ## Install NeoVIM

# neovim-WIN32:
# 	make --directory=$(DIR_INSTALL) i PACKAGE=neovim
# 	make neovim-postinstall
# 	# sed -e "s|~/.local/share|~/AppData/Local|g" -i $(NEO_CONFIG_PATH)/init.vim

# phpstorm: ## Install JetBrains PhpStorm
# 	make jetbrains JETBRAINS_IDE=phpstorm

# # phpstorm-LINUX:
# # 	sudo snap install phpstorm --classic

# # phpstorm-WIN32:
# # 	make --directory=$(DIR_INSTALL) dld URL="https://download.jetbrains.com/webide/silent.config"
# # 	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.jetbrains.com/phpstorm/download/download-thanks.html" PACKAGE_MATCH="PhpStorm.*.exe" PACKAGE_ARGS="/S /CONFIG=__HOME__\Downloads\silent.config /D=__PROGRAMFILES__\JetBrains\PhpStorm"


# PYCHARM=community
# # PYCHARM=professional
# pycharm: ## Install JetBrains PyCharm PYCHARM=community|professional
# 	make jetbrains JETBRAINS_IDE=pycharm-$(PYCHARM)

# # pycharm-WIN32:
# # 	make --directory=$(DIR_INSTALL) dld URL="https://download.jetbrains.com/python/silent.config" FILE="~/Downloads/silent.config"
# # 	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.jetbrains.com/pycharm/download/download-thanks.html?platform=windows" PACKAGE_MATCH="pycharm-professional.*.exe" PACKAGE_ARGS="/S /CONFIG=__HOME__\Downloads\silent.config /D=__PROGRAMFILES__\JetBrains\PyCharm-Professional"


# # pycharm-ce: pycharm-ce-$(OSFLAG) ## Install JetBrains PyCharm CE

# # pycharm-ce-LINUX:
# # 	sudo snap install pycharm-community --classic

# # # make --directory=$(DIR_INSTALL) dld URL="https://download.jetbrains.com/python/silent.config" FILE="~/Downloads/silent.config"
# # # make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.jetbrains.com/pycharm/download/download-thanks.html?platform=windows&code=PCC" PACKAGE_MATCH="pycharm-community.*.exe" PACKAGE_ARGS="/S /CONFIG=__HOME__\Downloads\silent.config /D=__PROGRAMFILES__\JetBrains\PyCharm-Community"
# # pycharm-ce-WIN32:
# # 	make --directory=$(DIR_INSTALL) dld URL="https://download.jetbrains.com/python/silent.config" FILE="__HOME__/Downloads/silent.config"
# # 	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.jetbrains.com/pycharm/download/" PACKAGE_MATCH="pycharm-community.*.exe" PACKAGE_ARGS="/S /CONFIG=__HOME__\Downloads\silent.config /D=__PROGRAMFILES__\JetBrains\PyCharm-Community"

# sublime: sublime-$(OSFLAG) ## Install Sublime Text

# sublime-WIN32:
# 	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.sublimetext.com/3" PACKAGE_MATCH="Sublime.*Setup" PACKAGE_ARGS="/SP- /VERYSILENT /NORESTART"

# sublime-LINUX: req_root_not
# 	sudo snap install sublime-text --classic

# vim: vim-$(OSFLAG) ## Install VIM

# # vim-WIN32:
# # 	@$(POWERSHELL) -Command "Write-Host -ForegroundColor Red '$(NOT_IMPLEMENTED_WINDOWS). Not supported.'"
# # 	@exit 1

# vim-LINUX: req_root_not
# 	sudo make --directory=$(DIR_INSTALL) essential
# 	sudo apt-get install -y vim
# 	cp .vimrc ~/.vimrc

# VSCODE=stable
# # VSCODE=insiders
# vscode: vscode-$(OSFLAG) ## Install Visual Studio Code VSCODE=stable,insiders

# vscode-WIN32:
# 	make --directory=$(DIR_INSTALL) dld URL="https://update.code.visualstudio.com/latest/win32-x64/$(VSCODE)" FILE="~/Downloads/vscode-$(VSCODE).exe"
# 	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/vscode-$(VSCODE).exe" PACKAGE_ARGS="/SP- /VERYSILENT /NORESTART"

# vscode-LINUX:
# ifeq ($(VSCODE),insiders)
# 	sudo snap install code-insiders --classic
# else
# 	sudo snap install code --classic
# endif

# webstorm: ## Install JetBrains WebStorm
# 	make jetbrains JETBRAINS_IDE=webstorm

# # webstorm-LINUX:
# # 	sudo snap install webstorm --classic

# # webstorm-WIN32:
# # 	make --directory=$(DIR_INSTALL) dld URL="https://download.jetbrains.com/webide/silent.config"
# # 	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.jetbrains.com/webstorm/download/download-thanks.html" PACKAGE_MATCH="WebStorm.*.exe" PACKAGE_ARGS="/S /CONFIG=__HOME__\Downloads\silent.config /D=__PROGRAMFILES__\JetBrains\WebStorm"
