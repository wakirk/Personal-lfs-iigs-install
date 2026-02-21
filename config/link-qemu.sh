#!/bin/bash


sudo pacman -Syu --needed spice-vdagent
sudo pacman -Syu --needed plasma-x11-session xorg-server
sudo pacman -Syu --needed tree mc
sudo umount /mnt/hostshare
sudo rmdir /mnt/hostshare
sudo mkdir -p /mnt/hostshare
sudo mount -t 9p -o trans=virtio,version=9p2000.L hostshare /mnt/hostshare
sudo ln -s /mnt/hostshare ~/share
exit 0
