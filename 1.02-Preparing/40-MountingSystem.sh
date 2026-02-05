#!/bin/bash

cd /home/lfs/lfs
source lib/menu.lib
cd 1.02-Preparing

echoL "Mounting Volumes..."

# Prepare mountpoints
echoL "Making mount points..."
mkdir -pv /mnt/lfs

# Mount root
echoL "Mounting root..."
mount -v /dev/sda2 /mnt/lfs

# Prepare mountpoints
echoL "Making mount points..."
mkdir -pv /mnt/lfs/boot/efi

# Mount EFI
echoL "Mounting EFI..."
mount -v /dev/sda1 /mnt/lfs/boot/efi

echoL "Partitioning and formatting complete."
lsblk
lsblk -f /dev/sda

exit 1
