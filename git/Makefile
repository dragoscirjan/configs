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
github-desktop: app-$(OSFLAG) ## Install GitKraken (https://desktop.github.com/)

gitkraken: APP_NAME=gitkraken
gitkraken: app-$(OSFLAG) ## Install GitKraken (https://www.gitkraken.com/)