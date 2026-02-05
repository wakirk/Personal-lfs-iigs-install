#!/bin/bash

cd /home/lfs/lfs
source lib/menu.lib
cd 1.02-Preparing

echoL "Formatting File System..."

# Format EFI
echoL "Formatting EFI..."
mkfs.vfat -F32 -n EFI /dev/sda1

# Format root
echoL "Formatting root..."
mkfs.ext4 -L LFSROOT /dev/sda2

# Init swap
echoL "Formatting swap..."
mkswap -L LINUXSWAP /dev/sda3

exit 1
