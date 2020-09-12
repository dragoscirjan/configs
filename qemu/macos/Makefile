include Makefile.template

DIR_INSTALL = ../.install

#
# Actual Action Definitions
# @see https://passthroughpo.st/new-and-improved-mac-os-tutorial-part-1-the-basics/
# @see https://github.com/foxlet/macOS-Simple-KVM/issues?utf8=%E2%9C%93&q=is%3Aissue+partition
# @see https://github.com/kholia/OSX-KVM
#

QEMU_DIR = ~/.qemu

MAC_VERSION = catalina
# MAC_VERSION = mojave
# MAC_VERSION = high-sierra

MAC_VERSION_COMMAND = bash ./jumpstart.sh --$(MAC_VERSION)
# MAC_VERSION_COMMAND = echo "Skipping jumpstart."

MAC_DRIVE ?= MyDisk.qcow2

ifeq ($(MAC_DRIVE),MyDisk.qcow2)
MAC_DRIVE_COMMAND = qemu-img create -f qcow2 MyDisk.qcow2 64G
# MAC_DRIVE_COMMAND2 = echo "    -drive id=SystemDisk,if=none,file=MyDisk.qcow2 \\" >> basic.sh
else 
MAC_DRIVE_COMMAND = echo "Skipping drive creation command. Will used user created file."
# MAC_DRIVE_COMMAND2 = echo "    -drive id=SystemDisk,if=none,file=$(MAC_DRIVE) \\" >> basic.sh
endif

init: ## Initialize project
	mkdir -p $(QEMU_DIR)
	
	cd $(QEMU_DIR) \
		&& [ -d macOS-Simple-KVM ] \
		|| git clone https://github.com/foxlet/macOS-Simple-KVM

	cd $(QEMU_DIR)/macOS-Simple-KVM \
		&& git pull \
		&& $(MAC_VERSION_COMMAND) \
		&& $(MAC_DRIVE_COMMAND) \
		&& echo "    -drive id=SystemDisk,if=none,file=$(MAC_DRIVE) \\" >> basic.sh \
		&& echo "    -device ide-hd,bus=sata.4,drive=SystemDisk \\" >> basic.sh \
		&& sed -e "s|-m 2G|-m 10G|g" -i basic.sh \
		&& sed -e "s|-smp 4,cores=2|-smp cores=2,threads=2,sockets=1|g" -i basic.sh

run: ## Run project
	cd $(QEMU_DIR)/macOS-Simple-KVM \
		&& sudo bash basic.sh

clean: ## Clear project
	rm -rf $(QEMU_DIR)/macOS-Simple-KVM
