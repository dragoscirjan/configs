include Makefile.template

#
# Actual Action Definitions
#

generic: norootcheck generic-$(OSID) ## Install Generic Utils

generic-debian:
	# http://ubuntuhandbook.org/index.php/2019/03/display-cpu-memory-network-usage-in-ubuntu-18-04-panel/
	sudo apt-get install gir1.2-gtop-2.0 gir1.2-networkmanager-1.0  gir1.2-clutter-1.0

generic-ubuntu: generic-debian

# https://medium.com/@pwaterz/how-to-dual-boot-windows-10-and-ubuntu-18-04-on-the-15-inch-dell-xps-9570-with-nvidia-1050ti-gpu-4b9a2901493d
xps15-9570: norootcheck generic ## Install Utils for XPS15 9570
	# Video Card
# 	make --directoru=../.install i PACKAGE="curl"
# 	sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/JackHack96/dell-xps-9570-ubuntu-respin/master/xps-tweaks.sh)"
# 	sudo prime-select intel
# 	sudo prime-select nvidia
	
	# Fix Touchpad
# 	sudo apt-get install xserver-xorg-input-libinput
# 	sudo apt-get remove --purge xserver-xorg-input-synaptics
# 	sudo reboot

	# Improve Battery Life
	sudo apt install update
	sudo apt install tlp tlp-rdw powertop
	sudo tlp start
	sudo powertop --auto-tune
# 	sudo reboot

	# Multi touch gestures
# 	sudo apt git install xdotool wmctrl libinput-tools
# 	sudo gpasswd -a $USER input
# 	gpasswd -a [your-user-name] input
# 	cd ~/Downloads
# 	git clone git@github.com:bulletmark/libinput-gestures.git
# 	cd libinput-gestures
# 	sudo ./libinput-gestures-setup install
# 	libinput-gestures-setup autostart
# 	libinput-gestures-setup start

	# Visual
	make --directory=../.install i PACKAGE="chrome-gnome-shell gnome-tweak-tool plank"

	# Reboot