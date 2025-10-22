#!/bin/bash
# qemu-boot-lfs.sh — BOOT /dev/nvme0n1 via UEFI in QEMU (WRITEABLE)
# WARNING: Writing to a disk that is mounted on the host can corrupt it.
# Set FORCE=1 to bypass the mounted-partitions check.

pacman -Sy --noconfirm edk2-ovmf

# does load.
#qemu-system-x86_64 -machine q35 -m 4096 \
#  -drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2-ovmf/x64/OVMF_CODE.4m.fd \
#  -drive if=pflash,format=raw,file=/usr/share/edk2-ovmf/x64/OVMF_VARS.4m.fd \
#  -drive file=/dev/nvme0n1,format=raw,if=virtio,cache=none

blockdev --getro /dev/nvme0n1
blockdev --setrw /dev/nvme0n1
qemu-system-x86_64 -machine q35 -enable-kvm -cpu host -m 4096 \
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2-ovmf/x64/OVMF_CODE.4m.fd \
  -drive if=pflash,format=raw,file=/usr/share/edk2-ovmf/x64/OVMF_VARS.4m.fd \
  -drive file=/dev/nvme0n1,format=raw,if=virtio,cache=none,discard=unmap \
  -boot order=c,menu=off,splash-time=0 -nic none
