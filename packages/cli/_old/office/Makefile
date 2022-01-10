include ./Makefile.template

#
# Actual Action Definitions
#

DIR_INSTALL = ../.install

libreoffice: libreoffice-$(OSFLAG) ## Install Libre Office

# libreoffice-LINUX:
# 	make --directory=$(DIR_INSTALL) i PACKAGE=libreoffice

# libreoffice-OSX:
# 	@echo $(NOT_IMPLEMENTED_OSX)

LIBRE_VERSION = 6.4.3
libreoffice-WIN32:
	make --directory=$(DIR_INSTALL) dld URL="https://www.libreoffice.org/donate/dl/win-x86_64/$(LIBRE_VERSION)/en-US/LibreOffice_$(LIBRE_VERSION)_Win_x64.msi" FILE="$$$$HOME\Downloads\libre-office.msi"
	make --directory=$(DIR_INSTALL) il PACKAGE_PATH="~/Downloads/libre-office.msi"


wpsoffice: wpsoffice-$(OSFLAG) ## Install WPS Office

# http://wps-community.org/downloads
wpsoffice-LINUX: wpsoffice-$(OSID)

# wpsoffice-ubuntu: wpsoffice-debian

# wpsoffice-debian:
# 	make --directory=$(DIR_INSTALL) iu URL="http://kdl.cc.ksosoft.com/wps-community/download/8722/wps-office_11.1.0.8722_amd64.deb" FILE="~/tmp/wps-office.deb"

# # wpsoffice-redhat:
# # 	make --directory=$(DIR_INSTALL) iu URL="http://kdl.cc.ksosoft.com/wps-community/download/8722/wps-office-11.1.0.8722-1.x86_64.rpm" FILE="~/tmp/wps-office.rpm"

# wpsoffice-OSX:
# 	@echo $(NOT_IMPLEMENTED_OSX)

# TODO: Doesn't accept knonwn args yet
wpsoffice-WIN32:
	make --directory=$(DIR_INSTALL) iu PACKAGE_URL="https://www.wps.com/" PACKAGE_MATCH="wps_office_inst.exe" PACKAGE_ARGS="/S /ACCEPTEULA=1"
