#!/bin/bash


if [ -f ~/.setup_finished ]; then
    sudo umount /mnt/hostshare 2>/dev/null
    sudo rmdir /mnt/hostshare 2>/dev/null
    sudo mkdir -p /mnt/hostshare
    sudo mount -t 9p -o trans=virtio,version=9p2000.L hostshare /mnt/hostshare
    cp -r ~/.config/* /home/wakirk/share/packages/kdeconfig/
else
    sudo pacman -Syu --needed --noconfirm spice-vdagent
    sudo pacman -Syu --needed --noconfirm plasma-x11-session xorg-server
    sudo pacman -Syu --needed --noconfirm tree mc
    sudo umount /mnt/hostshare 2>/dev/null
    sudo rmdir /mnt/hostshare 2>/dev/null
    sudo mkdir -p /mnt/hostshare
    sudo mount -t 9p -o trans=virtio,version=9p2000.L hostshare /mnt/hostshare
    sudo ln -s /mnt/hostshare /home/wakirk/share
    cp -r /home/wakirk/share/packages/kdeconfig/* ~/.config/
    sudo groupadd -r autologin
    sudo usermod -a -G autologin wakirk
    sudo mkdir -p /etc/sddm.conf.d
    echo -e "[Autologin]\nUser=wakirk\nSession=plasmax11" | sudo tee /etc/sddm.conf.d/autologin.conf
    touch ~/.setup_finished
fi

