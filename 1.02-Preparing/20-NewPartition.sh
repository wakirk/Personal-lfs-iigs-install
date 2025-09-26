#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.
cd /root/lfs/1.02-Preparing 

# Create EFI (2 GB, type EF00)
echoL "Creating EFI partition..."
sgdisk -n 1:0:+2G -t 1:EF00 -c 1:"EFI System" /dev/nvme0n1

# Create root (30 GB, type 8300)
echoL "Creating root partition..."
sgdisk -n 2:0:+30G -t 2:8300 -c 2:"LFS Root" /dev/nvme0n1

# Create swap (8 GB, type 8200)
echoL "Creating swap partition..."
sgdisk -n 3:0:+8G -t 3:8200 -c 3:"Linux Swap" /dev/nvme0n1

echoL "Cleaning residual data"
dd if=/dev/zero of=/dev/nvme0n1p1 bs=1M count=4096 status=progress
dd if=/dev/zero of=/dev/nvme0n1p2 bs=1M count=4096 status=progress
dd if=/dev/zero of=/dev/nvme0n1p3 bs=1M count=4096 status=progress

# Write changes
sync
blockdev --rereadpt /dev/nvme0n1

exit 1
