include ../Makefile.template

# --------------------------------------------------------------------------------------

default: ## Install default Git Tools (Git, Github Cli, GitKraken)
	make cli
	make gitkraken

cli:  ## Install default Cli Git Tools (Git, Github Cli)
	make git
	make github-cli

git: ## Install git (https://git-scm.com/)
	make app-$(OSFLAG) APP_NAME=git

	git config --global color.ui auto
	git config --global core.autocrlf false
	git config --global core.eol lf
	git config --global push.default matching

github-cli: APP_NAME=gh
github-cli: app-$(OSFLAG) ## Install GitKraken (https://cli.github.com/)

github-desktop: APP_NAME=github-desktop
github-desktop: github-desktop-$(OSFLAG) ## Install GitKraken (https://desktop.github.com/)

github-desktop-LINUX: APP_NAME=github-gui
github-desktop-LINUX: app-LINUX

github-desktop-OSX: app-OSX

github-desktop-WIN32: app-WIN32

gitkraken: APP_NAME=gitkraken
gitkraken: gitkraken-$(OSFLAG) ## Install GitKraken (https://www.gitkraken.com/)

gitkraken-LINUX: APP_ARGS=--classic
gitkraken-LINUX: app-LINUX

gitkraken-OSX: app-OSX

gitkraken-WIN32: app-WIN32