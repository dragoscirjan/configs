include ../../Makefile.template
include ../Makefile.qemu.template

DIR_INSTALL = ../../.install

#
# Actual Action Definitions
# @see https://passthroughpo.st/new-and-improved-mac-os-tutorial-part-1-the-basics/
# @see https://github.com/foxlet/macOS-Simple-KVM/issues?utf8=%E2%9C%93&q=is%3Aissue+partition
# @see https://github.com/kholia/OSX-KVM
#

WINDOWS_URL = https://www.microsoft.com/ro-ro/software-download/windows10ISO

init: ## Initialize project
	mkdir -p $(QEMU_DIR)
	mkdir -p $(QEMU_DIR)/windows
# 	bash ./jumpstart.sh -u $(UBUNTU_VERSION) -d "$(QEMU_DIR)/windows"
	echo "Download and save the Windows ISO under $(QEMU_DIR)/windows/windows.iso"
	xdg-open "$(WINDOWS_URL)" || gnome-open "$(WINDOWS_URL)"

WINDOWS_DISK =
WINDOWS_ISO =

run: ## Run project
	cwd=$$(pwd); \
		cd $(QEMU_DIR)/windows; \
		sudo bash $$cwd/basic.sh --disk "$(WINDOWS_DISK)" --iso "$(WINDOWS_ISO)"

run-local: ## Run project WINDOWS_ISO=~/.qemu/windows/windows.iso
	make run WINDOWS_DISK=/dev/disk/by-id/wwn-0x5001b448b8779485-part2

clean: ## Clear project
	rm -rf $(QEMU_DIR)/windows
