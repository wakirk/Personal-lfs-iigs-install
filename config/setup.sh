#!/bin/bash

# Setup script to configure installer env
# changes are to cache packages for faster, non-web blasthing trouble.

cat > /etc/pacman.conf <<'EOF'
[options]
HoldPkg     = pacman glibc
SigLevel    = Required DatabaseOptional
Architecture = auto

[core]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist

[multilib]
Include = /etc/pacman.d/mirrorlist
EOF

curl -fsSL 'https://archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4&use_mirror_status=on' \
  | sed 's/^#Server/Server/' \
  > /etc/pacman.d/mirrorlist

rm -rf /var/lib/pacman/sync/*
pacman -Syy --noconfirm archlinux-keyring gnupg
pacman-key --init
pacman-key --populate archlinux

echoL "Updating System..."

# Add "SigLevel = Never" once (for bootstrap)
grep -q '^SigLevel = Never' /etc/pacman.conf || sed -i '/^\[options\]/a SigLevel = Never' /etc/pacman.conf

# Refresh DBs
pacman -Syy --noconfirm

# 1) Remove the old owner (ignore deps—safe on live media)
pacman -Rdd --noconfirm linux-firmware

# 2) Install the split packages together so ownership is correct
pacman -S --noconfirm linux-firmware linux-firmware-nvidia

# Fix the firmware split conflict in one transaction
pacman -S --noconfirm linux-firmware linux-firmware-nvidia --overwrite '/usr/lib/firmware/nvidia/*'

# Ensure keyring/gnupg are current
pacman -S --noconfirm archlinux-keyring gnupg

# Restore normal signature policy (first occurrence only)
sed -i '0,/^SigLevel = Never/{s/^SigLevel = Never/SigLevel = Required DatabaseOptional/}' /etc/pacman.conf

