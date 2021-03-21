#! /bin/bash

systemctl disable systemd-resolved.service
systemctl stop systemd-resolved
rm /etc/dhcp/dhclient-enter-hooks.d/resolved
reboot
