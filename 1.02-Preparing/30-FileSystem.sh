#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.
cd /root/lfs/1.02-Preparing 

echoL "Formatting File System..."

# Format EFI
echoL "Formatting EFI..."
mkfs.vfat -F32 -n EFI /dev/nvme0n1p1

# Format root
echoL "Formatting root..."
mkfs.ext4 -L LFSROOT /dev/nvme0n1p2

# Init swap
echoL "Formatting swap..."
mkswap -L LINUXSWAP /dev/nvme0n1p3

exit 1
