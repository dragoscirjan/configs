include ../../Makefile.template
include ../Makefile.qemu.template

DIR_INSTALL = ../../.install

#
# Actual Action Definitions
# @see https://superuser.com/a/1504550
#

WINDOWS_DISK =

run: ## Run project
	[ -f ./bios.bin ] || sudo cp /usr/share/OVMF/OVMF_CODE.fd ./bios.bin
	cwd=$$(pwd); \
		cd $(QEMU_DIR)/windows; \
		sudo bash $$cwd/basic.sh --disk "$(WINDOWS_DISK)"

run-qual: ## Run project
	make run WINDOWS_DISK=/dev/disk/by-id/nvme-KINGSTON_SA2000M8500G_50026B7684626A8A
