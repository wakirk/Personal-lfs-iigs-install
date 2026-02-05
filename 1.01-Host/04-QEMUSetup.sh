#!/bin/bash

cd /home/lfs/lfs
source lib/menu.lib
cd 1.01-Host

echoR "Configuring Host"
echoL "Installing and Confuring QEMU..."

# QEMU + OVMF (Arch package names; choose JACK provider to avoid prompt)
pacman -S --noconfirm libcbor libfido2 qemu-system-x86 qemu-desktop qemu-ui-gtk edk2-ovmf pipewire-jack
pacman -S --noconfirm fuse3
pacman -Sy --noconfirm edk2-ovmf

# Refresh linker cache (belt-and-suspenders)
ldconfig

# Load KVM kernel modules required by your "-enable-kvm" flag
modprobe kvm 2>/dev/null || true
modprobe kvm_intel 2>/dev/null || modprobe kvm_amd 2>/dev/null || true

# Binary present + version OK (no GUI)
command -v qemu-system-x86_64
qemu-system-x86_64 --version

exit 1
