include Makefile.template

#
# Actual Action Definitions
#

all-minimal: termius ## Install Termius

all: all-minimal ## Install all-minimal

clb: pwsh7 ## Install Rest tools used @ CLB 


BASH_CONFIG_FOLDER=.
bash: bash-$(OSFLAG) ## Configure bash

bash-LINUX:
ifeq (bash,$(SHELL_IS))
	cp $(BASH_CONFIG_FOLDER)/bash_profile ~/.bash_profile.$(shell date +%s) || true
	cat ./bash_profile > ~/.bash_profile && source ~/.bash_profile
else
	echo $(SHELL)
	@echo "You're not using bash as shell interface."
endif

bash-OSX: bash-LINUX

bash-WIN32: bash-LINUX


conemu: conemu-$(OSFLAG) ## Install conemu (Windows)

conemu-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

conemu-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

conemu-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://download.fosshub.com/Protected/expiretime=1564737346;badurl=aHR0cHM6Ly93d3cuZm9zc2h1Yi5jb20vQ29uRW11Lmh0bWw=/cc407ff6eb89618cbdb63f8bb0dc7d991a47a0322e073683541f39753ffba2db/5b85860af9ee5a5c3e979f45/5d2b89f7ac7f050a7d238675/ConEmuSetup.190714.exe" FILE="~/tmp/conemu.exe"


cmder: cmder-$(OSFLAG) ## Install cmder (Windows)

cmder-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

cmder-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

cmder-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://github.com/cmderdev/cmder/releases/download/v1.3.11/cmder.zip" FILE="~/bin/cmder.zip"
	$(POWERSHELL) -Command "Expand-Archive ~/bin/cmder.zip -DestinationPath ~/bin/cmder"
	make --directory=$(DIR_INSTALL) rm FILE="~/bin/cmder.zip"


iterm: iterm-$(OSFLAG) ## Install iterm (MacOS)

iterm-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

iterm-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

iterm-WIN32:
	@echo $(NOT_IMPLEMENTED_WINDOWS)


guake: guake-$(OSFLAG) ## Install Guake (Linux)

guake-LINUX:
	apt install -y guake

guake-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

guake-WIN32:
	@echo $(NOT_IMPLEMENTED_OSX)


# hyper: hyper-$(OSFLAG) ## Install hyper

# hyper-LINUX: hyper-$(OSID)

# hyper-debian:
# 	make --directory=$(DIR_INSTALL) iu URL="https://releases.hyper.is/download/deb" FILE="~/tmp/hyper.deb"

# hyper-ubuntu: hyper-debian

# hyper-redhat:
# 	make --directory=$(DIR_INSTALL) iu URL="https://releases.hyper.is/download/rpm" FILE="~/tmp/hyper.rpm"

# hyper-OSX:
# 	@echo $(NOT_IMPLEMENTED_OSX)

# hyper-WIN32:
# 	make --directory=$(DIR_INSTALL) iu URL="https://releases.hyper.is/download/win" FILE="~/tmp/hyper.exe"


pwsh7: pwsh7-$(OSFLAG) ## Install PowerShell https://github.com/PowerShell/powershell

pwsh7-LINUX:
	snap install --classic powershell

pwsh7-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

pwsh7-WIN32:
	@echo $(NOT_IMPLEMENTED_OSX)


tabby: tabby-$(OSFLAG) ## Install Tabby Https://tabby.sh

tabby-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

tabby-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

tabby-WIN32:
	@echo $(NOT_IMPLEMENTED_WINDOWS)


termius: termius-$(OSFLAG) ## Install Termius https://termius.com

termius-LINUX:
	snap install termius

termius-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

termius-WIN32:
	@echo $(NOT_IMPLEMENTED_OSX)