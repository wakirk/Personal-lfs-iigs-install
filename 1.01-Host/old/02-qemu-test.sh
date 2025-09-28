#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.
cd /root/lfs/1.01-Host

# Show what accelerators QEMU sees
qemu-system-x86_64 -accel help

# Simple UI/KVM test
#qemu-system-x86_64 \
#  -enable-kvm \
#  -cpu host -m 512 \
#  -display gtk,zoom-to-fit=on \
#  -vga std \
#  -serial mon:stdio
  
# if not already: 
#qemu-system-x86_64 -enable-kvm -cpu host -m 512 -machine q35 \
#  -device virtio-vga -display gtk,zoom-to-fit=on \
#  -bios /usr/share/edk2-ovmf/x64/OVMF_CODE.fd -serial mon:stdio

# confirm which OVMF path you have:
ls /usr/share/edk2-ovmf/x64/OVMF_CODE.fd 2>/dev/null || ls /usr/share/edk2/x64/OVMF_CODE.fd

# then run with std VGA:
#qemu-system-x86_64 \
#  -enable-kvm \
#  -cpu host -m 512 \
#  -machine q35 \
#  -vga std \
#  -display gtk,zoom-to-fit=on \
#  -bios /usr/share/edk2-ovmf/x64/OVMF_CODE.fd \
#  -serial mon:stdio

exit 1
