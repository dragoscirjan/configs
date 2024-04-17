include ../Makefile.template

DIR_INSTALL = ../.install

#
# Actual Action Definitions
#

pm: pm-$(OSFLAG)

pm-LINUX: req_root ## Configure Bash
	echo

pm-OSX: ## Configure Zsh
	which brew > /dev/null || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# https://ohmyposh.dev/docs/installation/windows
# https://github.com/devblackops/Terminal-Icons
pm-WIN32: req_root pm--choco pm--scoop ## Install Windows Package Managers

pm--choco:
	$(POWERSHELL) -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"

pm--scoop:
	$(POWERSHELL) -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser; Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression"
