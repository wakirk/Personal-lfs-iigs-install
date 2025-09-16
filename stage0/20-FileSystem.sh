#!/bin/bash

source /root/lfs/lib/tmux.sh
cd /root/lfs/stage0

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




