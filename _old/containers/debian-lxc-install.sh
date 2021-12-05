#! /bin/bash


apt-get update
apt-get install -y lxc lxc-net libvirt0 libpam-cgfs bridge-utils
apt-get install -y libvirt-clients libvirt-daemon-system iptables ebtables dnsmasq-base

apt-get install snap

snap install core
snap install lxd

export PATH="$PATH:/snap/bin"

# Would you like to use LXD clustering? (yes/no) [default=no]: no
# Do you want to configure a new storage pool? (yes/no) [default=yes]: yes
# Name of the new storage pool [default=default]: default
# Name of the storage backend to use (dir, lvm, ceph, btrfs) [default=btrfs]: dir
# Would you like to connect to a MAAS server? (yes/no) [default=no]: no
# Would you like to create a new local network bridge? (yes/no) [default=yes]: yes
# What should the new bridge be called? [default=lxdbr0]: lxdbr0
# What IPv4 address should be used? (CIDR subnet notation, “auto” or “none”) [default=auto]: auto
# What IPv6 address should be used? (CIDR subnet notation, “auto” or “none”) [default=auto]: none
# Would you like LXD to be available over the network? (yes/no) [default=no]: no
# Would you like stale cached images to be updated automatically? (yes/no) [default=yes]: yes
# Would you like a YAML "lxd init" preseed to be printed? (yes/no) [default=no]: yes

cat | lxd init <<LXC
no
yes
default
dir
no
yes
lxdbr0
auto
none
no
yes
yes
LXC