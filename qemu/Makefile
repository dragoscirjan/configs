include ../Makefile.template
include ./Makefile.qemu.template

DIR_INSTALL=../.install

QEMU_PACKAGES=qemu qemu-utils qemu-kvm virt-manager libvirt-daemon-system libvirt-clients bridge-utils

install: req_root_not ## Install Qemu
	sudo make --directory=$(DIR_INSTALL) essential
	sudo apt install -y $(QEMU_PACKAGES) \
		|| sudo apt-get install -y $(QEMU_PACKAGES)