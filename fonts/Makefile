include ./Makefile.template

#
# Actual Action Definitions
#

DIR_INSTALL = ../.install

#
# Utils
#

mkfont: mkfont-$(SHELL_IS)

# mkfont-bash:
# ifeq ($(OSFLAG),OSX)
# 	# fix fuzzy fonts: https://medium.com/@mrahmadawais/fix-macos-mojave-blurry-font-rendering-issue-4331757b0776
# 	defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
# endif
# 	mkdir -p ~/.fonts

mkfont-powershell:
	$(POWERSHELL) -Command "New-Item -Path ~\Downloads -Name fonts -ItemType directory -Force"

win-fonts-unzip:
	$(POWERSHELL) -Command "Expand-Archive -Force ~/Downloads/fonts.zip -DestinationPath ~/Downloads/fonts"

# fonts-LINUX:
# 	unzip ~/Downloads/fonts.zip -d ~/Downloads/fonts
# 	find ~/Downloads/fonts -iname "*.ttf" | while read font; do echo "Installing '$$font' ..."; cp "$$font" ~/.fonts; done

# fonts-LINUX-otf:
# 	unzip ~/Downloads/fonts.zip -d ~/Downloads/fonts
# 	find ~/Downloads/fonts -iname "*.otf" | while read font; do echo "Installing '$$font' ..."; cp "$$font" ~/.fonts; done

# fonts-OSX:
# 	unzip ~/Downloads/fonts.zip -d ~/Downloads/fonts
# 	find ~/Downloads/fonts -iname "*.ttf" | while read font; do echo "Installing '$$font' ..."; cp "$$font" ~/Library/Fonts; done

# fonts-OSX-otf:
# 	unzip ~/Downloads/fonts.zip -d ~/Downloads/fonts
# 	find ~/Downloads/fonts -iname "*.otf" | while read font; do echo "Installing '$$font' ..."; cp "$$font" ~/Library/Fonts; done

#
# Actual Action Definitions
#

firacode: mkfont firacode-dld firacode-$(OSFLAG) ## Install Fira Code Font https://github.com/tonsky/FiraCode
	make --directory=$(DIR_INSTALL) rm FILE="$$$$HOME\Downloads\fonts"

firacode-dld:
	make --directory=$(DIR_INSTALL) dld URL="https://github.com/tonsky/FiraCode/releases/download/1.206/FiraCode_1.206.zip" FILE="$$$$HOME\Downloads\fonts.zip"

# firacode-LINUX: firacode-dld fonts-LINUX
# 	make --directory=$(DIR_INSTALL) rm FILE="$$$$HOME\Downloads\fonts.zip"

# firacode-OSX: firacode-dld
# 	@echo $(NOT_IMPLEMENTED_OSX)

firacode-WIN32: firacode-dld win-fonts-unzip
	$(POWERSHELL) -File ./install-font.ps1


hasklig: mkfont hasklig-$(OSFLAG) ## Install Hasklig Font https://github.com/i-tu/Hasklig
	make --directory=$(DIR_INSTALL) rm FILE="$$$$HOME\Downloads\fonts"

hasklig-dld:
	make --directory=$(DIR_INSTALL) dld URL="https://github.com/i-tu/Hasklig/releases/download/1.1/Hasklig-1.1.zip" FILE="$$$$HOME\Downloads\fonts.zip"

# hasklig-LINUX: hasklig-dld fonts-LINUX-otf

# hasklig-OSX: hasklig-dld fonts-OSX-otf

hasklig-WIN32: hasklig-dld win-fonts-unzip
	$(POWERSHELL) -File ./install-font.ps1 --ext otf


monoid: mkfont monoid-$(OSFLAG) ## Install Monoid Font https://github.com/larsenwork/monoid
	make --directory=$(DIR_INSTALL) rm FILE="$$$$HOME\Downloads\fonts"

monoid-dld:
# 	make --directory=$(DIR_INSTALL) dld URL="https://github.com/larsenwork/monoid/archive/0.61.zip" FILE="$$$$HOME\Downloads\fonts.zip"
	make --directory=$(DIR_INSTALL) dld URL="https://raw.githubusercontent.com/larsenwork/monoid/2db2d289f4e61010dd3f44e09918d9bb32fb96fd/Monoid.zip" FILE="$$$$HOME\Downloads\fonts.zip"

# monoid-LINUX: monoid-dld fonts-LINUX

# monoid-OSX: monoid-dld fonts-OSX

monoid-WIN32: monoid-dld win-fonts-unzip
	$(POWERSHELL) -File ./install-font.ps1

NERD_FONTS_VERSION = 2.1.0
nerd: mkfont nerd-$(OSFLAG) ## Install Nerd https://github.com/ryanoasis/nerd-fonts

nerd-dld:
	make --directory=$(DIR_INSTALL) dld URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v$(NERD_FONTS_VERSION)/Hack.zip" FILE="$$$$HOME\Downloads\Hack.zip"
	make --directory=$(DIR_INSTALL) dld URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v$(NERD_FONTS_VERSION)/Hasklig.zip" FILE="$$$$HOME\Downloads\Hasklig.zip"
	make --directory=$(DIR_INSTALL) dld URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v$(NERD_FONTS_VERSION)/SourceCodePro.zip" FILE="$$$$HOME\Downloads\SourceCodePro.zip"

# nerd-LINUX: nerd-hasklig-dld fonts-LINUX-otf

# nerd-OSX: nerd-hasklig-dld fonts-OSX-otf

nerd-WIN32: nerd-dld
	$(POWERSHELL) -Command "Expand-Archive -Force ~/Downloads/Hack.zip -DestinationPath ~/Downloads/fonts"
	$(POWERSHELL) -Command "Expand-Archive -Force ~/Downloads/Hasklig.zip -DestinationPath ~/Downloads/fonts"
	$(POWERSHELL) -Command "Expand-Archive -Force ~/Downloads/SourceCodePro.zip -DestinationPath ~/Downloads/fonts"
	$(POWERSHELL) -File ./install-font.ps1 -Ext otf
	$(POWERSHELL) -File ./install-font.ps1


sourcecodepro: mkfont sourcecodepro-$(OSFLAG) ## Install Source Code Pro Font https://github.com/adobe-fonts/source-code-pro
	make --directory=$(DIR_INSTALL) rm FILE="$$$$HOME\Downloads\fonts"

sourcecodepro-dld:
	make --directory=$(DIR_INSTALL) dld URL="https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Italic.ttf" FILE="~/tmp/fonts/SourceCodeVariable-Italic.ttf"
	make --directory=$(DIR_INSTALL) dld URL="https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Roman.ttf" FILE="~/tmp/fonts/SourceCodeVariable-Roman.ttf"

# sourcecodepro-LINUX: sourcecodepro-dld fonts-LINUX

# sourcecodepro-OSX: sourcecodepro-dld
# 	@echo $(NOT_IMPLEMENTED_OSX)

sourcecodepro-WIN32: sourcecodepro-dld win-fonts-unzip
	$(POWERSHELL) -File ./install-font.ps1

all: firacode hasklig monoid sourcecodepro ## Install all Fonts
