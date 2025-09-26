#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.
cd /root/lfs/1.02-Preparing 

echoR "Preparing Partitions"
echoL "Removing any mounts..."
umount -v /dev/nvme0n1p*

echoL "Cleaning Disk..."
# 1. Wipe first 10MB (MBR + GPT primary + boot code area)
dd if=/dev/zero of=/dev/nvme0n1 bs=1M count=4096 status=progress

# 2. Wipe last 10MB (GPT backup + end-of-disk junk)
dd if=/dev/zero of=/dev/nvme0n1 bs=1M count=4096 seek=$(( $(blockdev --getsz /dev/nvme0n1) / 2048 - 4096 )) status=progress

# 3. Clear filesystem/RAID/LVM signatures
wipefs -a /dev/nvme0n1
blockdev --rereadpt /dev/nvme0n1
udevadm settle
lsblk

echo "Drive Clean"

exit 1
