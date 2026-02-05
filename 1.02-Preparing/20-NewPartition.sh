#!/bin/bash

cd /home/lfs/lfs
source lib/menu.lib
cd 1.02-Preparing

# Create EFI (2 GB, type EF00)
echoL "Creating EFI partition..."
sgdisk -n 1:0:+1G -t 1:EF00 -c 1:"EFI System" /dev/sda

# Create root (30 GB, type 8300)
echoL "Creating root partition..."
sgdisk -n 2:0:+50G -t 2:8300 -c 2:"LFS Root" /dev/sda

# Create swap (8 GB, type 8200)
echoL "Creating swap partition..."
sgdisk -n 3:0:+8G -t 3:8200 -c 3:"Linux Swap" /dev/sda

echoL "Cleaning residual data"
dd if=/dev/zero of=/dev/sda1 bs=1M count=4096 status=progress
dd if=/dev/zero of=/dev/sda2 bs=1M count=4096 status=progress
dd if=/dev/zero of=/dev/sda3 bs=1M count=4096 status=progress

# Write changes
sync
blockdev --rereadpt /dev/sda

exit 1
