#! /bin/bash

#
# @see https://superuser.com/a/1504550
#

# DISK=/dev/disk/by-id/nvme-KINGSTON_SA2000M8500G_50026B7684626A8A
DISK=/dev/nvme0n1

[ -f ./bios.bin ] || cp /usr/share/OVMF/OVMF_CODE.fd ./bios.bin

qemu-system-x86_64 \
    --machine pc-q35-4.0 \
    -enable-kvm                                   `# enable KVM optimiations` \
    -L .                                          `# dir with bios.bin` \
    --bios ./bios.bin                             `# bios.bin itself` \
    -m 8G                                         `# provide reasonable amount of ram` \
    -cpu host                                     `# match the CPU type exactly` \
    -drive file=$DISK,format=raw,media=disk       `# load raw HDD` \
    -enable-kvm \
    -cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time \
    -machine type=pc,accel=kvm \
    -vga virtio
    # -vga qxl \
    # -global qxl-vga.ram_size=134217728 \
    # -global qxl-vga.vram_size=134217728 \
    # -global qxl-vga.vgamem_mb=32
    # -spice port=5930,disable-ticketing \
    # -device virtio-serial \
    # -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
    # -chardev spicevmc,id=spicechannel0,name=vdagent
    # -machine type=pc,accel=kvm \
    # -smp $(nproc) \
