include ../../Makefile.template
include ../Makefile.qemu.template

DIR_INSTALL = ../../.install

#
# Actual Action Definitions
# @see https://passthroughpo.st/new-and-improved-mac-os-tutorial-part-1-the-basics/
# @see https://github.com/foxlet/macOS-Simple-KVM/issues?utf8=%E2%9C%93&q=is%3Aissue+partition
# @see https://github.com/kholia/OSX-KVM
#

UBUNTU_VERSION = 20.04

init: ## Initialize project
	mkdir -p $(QEMU_DIR)
	mkdir -p $(QEMU_DIR)/ubuntu
	bash ./jumpstart.sh -u $(UBUNTU_VERSION) -d "$(QEMU_DIR)/ubuntu"

UBUNTU_DISK =
UBUNTU_ISO =

run: ## Run project
	cwd=$$(pwd); \
		cd $(QEMU_DIR)/ubuntu; \
		sudo bash $$cwd/basic.sh --disk "$(UBUNTU_DISK)" --iso "$(UBUNTU_ISO)"

run-local: ## Run project
	make run UBUNTU_DISK=/dev/disk/by-id/wwn-0x5001b448b8779485-part1

clean: ## Clear project
	rm -rf $(QEMU_DIR)/ubuntu
