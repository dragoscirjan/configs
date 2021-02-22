include ../Makefile.template

DIR_INSTALL = ../../.install

#
# Actual Action Definitions
# @see https://passthroughpo.st/new-and-improved-mac-os-tutorial-part-1-the-basics/
# @see https://github.com/foxlet/macOS-Simple-KVM/issues?utf8=%E2%9C%93&q=is%3Aissue+partition
# @see https://github.com/kholia/OSX-KVM
#

UBUNTU_VERSION = 20.04

openvpn: req_root ## Install OpenVPN
	sudo apt-get install -y openvpn network-manager-openvpn \
		network-manager-openvpn-gnome gadmin-openvpn-client gadmin-openvpn-server
