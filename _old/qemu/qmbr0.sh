#! /bin/bash
set -ex

# https://www.linux-kvm.org/page/Networking

ip link list | grep qmbr0 || ( ip link add qmbr0 type bridge && ip link set enp6s0 master qmbr0 )
