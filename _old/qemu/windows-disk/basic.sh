#!/bin/bash
set -ex

# ISO=

# DISK=
# DISK_SIZE=5G

RAM_SIZE=16G

CPU_CORES=1

MAC_ADDRESS=$(printf 'DE:AD:BE:EF:%02X:%02X\n' $((RANDOM%256)) $((RANDOM%256)))

VGA_DRIVER=virtio
# VGA_DRIVER=qxl

[ -f ./bios.bin ] \
  || ( cp /usr/share/OVMF/OVMF_CODE.fd ./bios.bin \
    && chmod 555 ./bios.bin )

POSITIONAL=()
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
      -i|--iso)
      ISO="$2"
      shift # past argument
      shift # past value
      ;;
      -d|--disk)
      DISK="$2"
      shift # past argument
      shift # past value
      ;;
      -r|--ram)
      RAM_SIZE="$2"
      shift # past argument
      shift # past value
      ;;
      -c|--cores)
      CPU_CORES="$2"
      shift # past argument
      shift # past value
      ;;
      -v|--vga)
      VGA_DRIVER="$2"
      shift # past argument
      shift # past value
      ;;
      *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
  esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

qemuArgs=()

[[ -f "$ISO" ]] && qemuArgs+=(-cdrom $ISO)

if [[ "$DISK" == "" ]]; then
  echo "No drive mentioned."
  exit 10G
fi
qemuArgs+=(-drive file=$DISK,format=raw,media=disk)

# https://www.linux-kvm.org/page/Networking
# qemuArgs+=(-netdev user,id=user.0 -device e1000,netdev=user.0)
# qemuArgs+=(-device e1000,netdev=net0,mac=$MAC_ADDRESS -netdev tap,id=net0)

if [[ "$VGA_DRIVER" == "virtio" ]]; then
  qemuArgs+=(-vga virtio)
else
  if [[ "$VGA_DRIVER" == "qxl" ]]; then
    qemuArgs+=(-vga qxl)
    qemuArgs+=(-global qxl-vga.ram_size=134217728)
    qemuArgs+=(-global qxl-vga.vram_size=134217728)
    qemuArgs+=(-global qxl-vga.vgamem_mb=32)
  else
    echo "Only 'virtio' and 'qxl' are supported for now."
  fi
fi

# MACHINE=q35,accel=kvm
MACHINE=pc,accel=kvm

qemu-system-x86_64 \
  -enable-kvm \
  -L . --bios ./bios.bin \
  -m $RAM_SIZE \
  -machine $MACHINE \
  -smp cores=$CPU_CORES,threads=$CPU_CORES,sockets=1 \
  -usb \
  -device usb-kbd \
  -device usb-mouse \
  -display default \
  -enable-kvm \
  -cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time \
  "${qemuArgs[@]}"

# -device ich9-ahci,id=sata \
  # -boot order=c,menu=on \

  # -acpitable file=$(pwd)/slic.bi

# qemu-system-x86_64 \
#     -enable-kvm \
#     -m 10G \
#     -machine q35,accel=kvm \
#     -smp cores=2,threads=2,sockets=1 \
#     -cpu Penryn,vendor=GenuineIntel,kvm=on,+sse3,+sse4.2,+aes,+xsave,+avx,+xsaveopt,+xsavec,+xgetbv1,+avx2,+bmi2,+smep,+bmi1,+fma,+movbe,+invtsc \
#     -device isa-applesmc,osk="$OSK" \
#     -smbios type=2 \
#     -drive if=pflash,format=raw,readonly,file="$OVMF/OVMF_CODE.fd" \
#     -drive if=pflash,format=raw,file="$OVMF/OVMF_VARS-1024x768.fd" \
#     -vga qxl \
#     -device ich9-intel-hda -device hda-output \
#     -usb -device usb-kbd -device usb-mouse \
#     -netdev user,id=net0 \
#     -device e1000-82545em,netdev=net0,id=net0,mac=52:54:00:c9:18:27 \
#     -device ich9-ahci,id=sata \
#     -drive id=ESP,if=none,format=qcow2,file=ESP.qcow2 \
#     -device ide-hd,bus=sata.2,drive=ESP \
#     -drive id=InstallMedia,format=raw,if=none,file=BaseSystem.img \
#     -device ide-hd,bus=sata.3,drive=InstallMedia \
#     -drive id=SystemDisk,if=none,file=/dev/disk/by-id/ata-WDC_WDS240G2G0B-00EPW0_192927804966-part2 \
#     -device ide-hd,bus=sata.4,drive=SystemDisk \
