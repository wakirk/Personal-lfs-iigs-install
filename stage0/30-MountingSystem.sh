#!/bin/bash

source /root/lfs/lib/tmux.sh
cd /root/lfs/stage0

echoL "Mounting Volumes..."


# Mount root
echoL "Mounting root..."
mount -v /dev/nvme0n1p2 /mnt/lfs

# Prepare mountpoints
echoL "Making mountpoints..."
mkdir -pv /mnt/lfs
mkdir -pv /mnt/lfs/boot/efi

# Mount EFI
echoL "Mounting EFI..."
mount -v /dev/nvme0n1p1 /mnt/lfs/boot/efi

echoL "Partitioning and formatting complete."
lsblk
lsblk -f /dev/nvme0n1

