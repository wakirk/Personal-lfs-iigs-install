#!/bin/bash


sudo pacman -Syu --needed --noconfirm spice-vdagent
sudo pacman -Syu --needed --noconfirm plasma-x11-session xorg-server
sudo pacman -Syu --needed --noconfirm tree mc
sudo umount /mnt/hostshare
sudo rmdir /mnt/hostshare
sudo mkdir -p /mnt/hostshare
sudo mount -t 9p -o trans=virtio,version=9p2000.L hostshare /mnt/hostshare
sudo ln -s /mnt/hostshare /home/wakirk/share
exit 0
