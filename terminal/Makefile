include ./Makefile.template

#
# Actual Action Definitions
#

DIR_INSTALL = ../.install


BASH_CONFIG_FOLDER=.
bash: bash-$(OSFLAG) ## Configure bash
	cat ~/.bash_profile | grep ssh-j-linux || echo "alias ssh-j-linux='ssh dragosc@192.168.98.60'" >> ~/.bash_profile

bash-LINUX:
ifeq (bash,$(SHELL_IS))
	cp ~/.bash_aliases ~/.bash_aliases.$(shell date +%s) || true
	cat ./bash_aliases > ~/.bash_aliases && source ~/.bash_aliases
# 	cp $(BASH_CONFIG_FOLDER)/bash_profile ~/.bash_profile.$(shell date +%s) || true
# 	cat ./bash_profile > ~/.bash_profile && source ~/.bash_profile
else
	echo $(SHELL)
	@echo "You're not using bash as shell interface."
endif

bash-OSX: bash-LINUX

bash-WIN32: bash-LINUX

conemu: conemu-$(OSFLAG) ## Install conemu

conemu-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

conemu-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

#  PACKAGE_ARGS="/p:x64,adm /qr"
conemu-WIN32:
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.fosshub.com/ConEmu.html" PACKAGE_MATCH="ConEmuSetup.*.exe" PACKAGE_ARGS="/p:x64 /q"


CMDER_VERSION = 1.3.14
cmder: cmder-$(OSFLAG) ## Install cmder

cmder-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

cmder-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

cmder-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://github.com/cmderdev/cmder/releases/download/v$(CMDER_VERSION)/cmder.zip" FILE="~/bin/cmder.zip"
	$(POWERSHELL) -Command "Expand-Archive ~/bin/cmder.zip -DestinationPath ~/bin/cmder"

iterm: iterm-$(OSFLAG) ## Install iterm

iterm-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

iterm-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

iterm-WIN32:
	@echo $(NOT_IMPLEMENTED_WINDOWS)


guake: guake-$(OSFLAG) ## Install Guake

guake-LINUX:
	make --directory=$(DIR_INSTALL) i guake

guake-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

guake-WIN32:
	@echo $(NOT_IMPLEMENTED_OSX)


hyper: hyper-$(OSFLAG) ## Install hyper

# hyper-LINUX: hyper-$(OSID)

# hyper-debian:
# 	make --directory=$(DIR_INSTALL) iu URL="https://releases.hyper.is/download/deb" FILE="~/tmp/hyper.deb"

# hyper-ubuntu: hyper-debian

# hyper-redhat:
# 	make --directory=$(DIR_INSTALL) iu URL="https://releases.hyper.is/download/rpm" FILE="~/tmp/hyper.rpm"

# hyper-OSX:
# 	@echo $(NOT_IMPLEMENTED_OSX)

# TODO: No unknown silent args
hyper-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://releases.hyper.is/download/win" FILE="$$$$HOME\Downloads\hyper.exe"
	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/hyper.exe" PACKAGE_ARGS="/S"
