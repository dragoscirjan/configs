include ./Makefile.template

#
# Actual Action Definitions
#

CURL=curl -SL
ifeq (powershell,$(SHELL_IS))
	CURL=powershell -ExecutionPolicy ByPass -File ../.ps/curl.ps1 --url
endif

#
# Utils
#

apt-utils:
ifeq (LINUX,$(OSFLAG))
	which apt > /dev/null && sudo apt install apt-transport-https
	which apt-get > /dev/null && sudo apt-get install -y apt-transport-https curl bzip2 gzip
endif

#
# Download File
#

dld: apt-utils dld-$(SHELL_IS) ## Download file from web for installing: make dld URL=http://... FILE=./file.exe

dld-bash:
	$(CURL) "$(URL)" --output $(FILE)

dld-powershell:
	$(CURL) "$(URL)" --output "$(FILE)"

#
# Install Local Package
#

PACKAGE =
i: i-$(OSFLAG) ## Install From Package Manager PACKAGE=...

CHOKO_FLAGS =
i-WIN32:
	$(POWERSHELL) -Command "chocolatey.exe install $(CHOKO_FLAGS) $(PACKAGE)"

#
# Install URL Package
#

PACKAGE_URL =
PACKAGE_MATCH =
PACKAGE_ARGS =
iu: iu-$(OSFLAG) ## Install From URL PACKAGE_URL=... PACKAGE_MATCH=... PACKAGE_ARGS=...

iu-WIN32:
	$(POWERSHELL) -File ../.ps/install.ps1 --Url "$(PACKAGE_URL)" --FileMatch "$(PACKAGE_MATCH)" --ArgumentList "$(PACKAGE_ARGS)"

#
# Install Local Package
#

PACKAGE_PATH =
il: il-$(OSFLAG) ## Install Local Package PACKAGE_PATH=... PACKAGE_ARGS=...

il-WIN32:
	$(POWERSHELL) -File ../.ps/install.ps1 --File "$(PACKAGE_PATH)" --ArgumentList "$(PACKAGE_ARGS)"

#
# Install Package
#

# i: apt-utils i-$(OSFLAG) ## Install Package Depending on OS BREW_SOURCE=,cask

# i-LINUX: i-$(OSID)

# i-ubuntu:
# 	sudo apt update
# 	sudo apt install -y $(PACKAGE)

# i-debian:
# 	sudo apt-get update
# 	sudo apt-get install -y $(PACKAGE)

# # 	which dnf > /dev/null && sudo dnf install -y $(PACKAGE)
# # 	which yum > /dev/null && sudo yum install -y $(PACKAGE)

# BREW_SOURCE=
# # BREW_SOURCE=cask
# i-OSX:
# 	brew $(BREW_SOURCE) list | grep $(PACKAGE) || brew $(BREW_SOURCE) install $(PACKAGE)
# 	brew $(BREW_SOURCE) list | grep $(PACKAGE) && brew $(BREW_SOURCE) reinstall $(PACKAGE)

# i-WIN32:
# 	choko install $(PACKAGE)

# #
# # Install from Local File
# #

# il: apt-utils il-$(OSFLAG)-$(SHELL_IS) ## Install Local Package Depending on OS

# il-LINUX-bash: il-LINUX-bash-$(OSID)

# il-LINUX-bash-ubuntu: il-LINUX-bash-debian

# il-LINUX-bash-debian:
# 	sudo dpkg -i $(FILE) || sudo apt-get install -fy

# il-OSX-bash:
# 	# http://commandlinemac.blogspot.com/2008/12/installing-dmg-application-from-command.html
# 	hdiutil mount $(FILE) -mountpoint $$HOME/tmp/volume
# 	find $$HOME/tmp/volume -type d -iname "*.app" -mindepth 1 -maxdepth 1 \
# 		| while read app; do sudo cp -R "$$app" /Applications; done
# 	find $$HOME/tmp/volume -type f -iname "*.pkg" -mindepth 1 -maxdepth 1 \
# 		| while read app; do echo sudo installer -package $$app -target "/Volumes/Macintosh HD"; done
# 	hdiutil unmount $$HOME/tmp/volume

# il-WIN32-bash:
# 	$(POWERSHELL) -File ../.ps/install.ps1 --file "$(FILE)" --args "$(IL_WIN_ARGS)"

# il-WIN32-powershell: il-WIN32-bash


# #
# # Install from URL
# #

# iu: dld iu-$(OSFLAG)-$(SHELL_IS) ## Install URL Package Depending on OS

# iu-LINUX-bash:
# 	make il-LINUX-bash FILE="$(FILE)"
# 	make rm

# iu-OSX-bash:
# 	@echo "$(NOT_IMPLEMENTED_OSX)"

# iu-WIN32-bash:
# 	make il-WIN32-bash FILE="$(FILE)" IL_WIN_ARGS="$(IL_WIN_ARGS)"
# 	make rm

# iu-WIN32-powershell: iu-WIN32-bash
