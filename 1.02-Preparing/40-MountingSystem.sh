#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.
cd /root/lfs/1.02-Preparing 

echoL "Mounting Volumes..."

# Prepare mountpoints
echoL "Making mount points..."
mkdir -pv /mnt/lfs

# Mount root
echoL "Mounting root..."
mount -v /dev/nvme0n1p2 /mnt/lfs

# Prepare mountpoints
echoL "Making mount points..."
mkdir -pv /mnt/lfs/boot/efi

# Mount EFI
echoL "Mounting EFI..."
mount -v /dev/nvme0n1p1 /mnt/lfs/boot/efi

echoL "Partitioning and formatting complete."
lsblk
lsblk -f /dev/nvme0n1

exit 1
