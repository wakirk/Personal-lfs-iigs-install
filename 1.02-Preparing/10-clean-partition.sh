#!/bin/bash

cd /home/lfs/lfs
source lib/menu.lib
cd 1.02-Preparing

echoR "Preparing Partitions"
echoL "Removing any mounts..."
umount -v /dev/sda*

echoL "Cleaning Disk..."
# 1. Wipe first 10MB (MBR + GPT primary + boot code area)
dd if=/dev/zero of=/dev/sda bs=1M count=4096 status=progress

# 2. Wipe last 10MB (GPT backup + end-of-disk junk)
dd if=/dev/zero of=/dev/sda bs=1M count=4096 seek=$(( $(blockdev --getsz /dev/sda) / 2048 - 4096 )) status=progress

# 3. Clear filesystem/RAID/LVM signatures
wipefs -a /dev/sda
blockdev --rereadpt /dev/sda
udevadm settle
lsblk

echo "Drive Clean"

exit 1
