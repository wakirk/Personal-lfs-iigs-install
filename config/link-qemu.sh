#!/bin/bash

sudo pacman -Syu --needed spice-vdagent
sudo pacman -Syu --needed plasma-x11-session xorg-server
sudo pacman -Syu --needed tree mc
mkdir -p /mnt/hostshare
mount -t 9p -o trans=virtio,version=9p2000.L hostshare /mnt/hostshare
ln -s /mnt/hostshare ~/share
exit 0
