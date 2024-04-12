include ../Makefile.template

#
# Actual Action Definitions
#

DIR_INSTALL = ../.install


bash: ## Configure Bash
	echo

zsh: ## Configure Zsh
	echo

# https://ohmyposh.dev/docs/installation/windows
# https://github.com/devblackops/Terminal-Icons
posh: ## Configure Posh
	winget install JanDeDobbeleer.OhMyPosh -s winget

	$(POWERSHELL) -Command "Install-Module -Name Terminal-Icons -Repository PSGallery"
