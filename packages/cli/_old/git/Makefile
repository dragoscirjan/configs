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
	# TODO: Find a list of arguments to fit your way of working
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://git-scm.com/download/win" PACKAGE_MATCH="Git.*.exe"
	#PACKAGE_ARGS="/VERYSILENT /NORESTART /NOCANCEL /SP- /NOCLOSEAPPLICATIONS /NORESTARTAPPLICATIONS /COMPONENTS=\"icons,ext\reg\shellhere,assoc,assoc_sh\""


gitkraken: gitkraken-$(OSFLAG) ## Install GitKraken

gitkraken-LINUX:
	@echo $(NOT_IMPLEMENTED_LINUX)

gitkraken-OSX:
	@echo $(NOT_IMPLEMENTED_OSX)

gitkraken-WIN32:
	$(POWERSHELL) -Command 'make --directory=$(DIR_INSTALL) dld URL="https://release.gitkraken.com/win64/GitKrakenSetup.exe" FILE="$$HOME\Downloads\GitKrakenSetup.exe"'
	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/GitKrakenSetup.exe" PACKAGE_ARGS="/VERYSILENT /NORESTART /NOCANCEL /SP- /NOCLOSEAPPLICATIONS /NORESTARTAPPLICATIONS"
