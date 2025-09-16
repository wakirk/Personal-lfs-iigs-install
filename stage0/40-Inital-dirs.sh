#!/bin/bash

source /root/lfs/lib/tmux.sh
cd /root/lfs/stage0

echoL "Initial Directories..."

mkdir -p /mnt/lfs/home
mkdir -p /mnt/lfs/usr
mkdir -p /mnt/lfs/opt
mkdir -p /mnt/lfs/tmp
mkdir -p /mnt/lfs/usr/src
chmod 1777 /mnt/lfs/tmp

echo LFS = $LFS
ls $LFS -l
echo umask: 
umask

