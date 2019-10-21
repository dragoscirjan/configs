include Makefile.template

DIR_INSTALL = ../.install

#
# Actual Action Definitions
#

git: git-$(OSFLAG) ## Install Git
	git config --global color.ui auto
	git config --global core.autocrlf false
	git config --global core.eol lf
	git config --global push.default matching

git-LINUX:
	make --director=$(DIR_INSTALL) i PACKAGE=git

git-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

git-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://github.com/git-for-windows/git/releases/download/v2.22.0.windows.1/Git-2.22.0-64-bit.exe" FILE="~/tmp/git.exe"


gitkraken: gitkraken-$(OSFLAG) ## Install GitKraken

gitkraken-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

gitkraken-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

gitkraken-WIN32:
	make --directory=$(DIR_INSTALL) iu URL="https://release.gitkraken.com/win64/GitKrakenSetup.exe" FILE="~/tmp/git-kraken.exe"