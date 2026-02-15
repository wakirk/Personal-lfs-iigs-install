#!/bin/bash

# Setup script to configure installer env
# changes are to cache packages for faster, non-web blasthing trouble.

# -------------- old pacman (make it work) code
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

# new cache off line code:
# -------------------------------------------------------------
# --- PACMAN PERSISTENT CACHE LOGIC ---

# 1. Define the persistent storage location
PACACHE="/mnt/share/pacman"
mkdir -p "$PACACHE"  

echo "--- Checking for updates and building cache at $PACACHE ---"

# 2. Build/Refresh the Cache
# This syncs the databases (-Sy) and downloads all needed packages (-w) 
# into the persistent PACACHE directory.
# If the packages are already there and up-to-date, it skips them.
pacman -Syuw --noconfirm --cachedir "$PACACHE"

echo "--- Cache build/refresh complete. Starting upgrade from local storage ---"

# 3. Perform the Upgrade
# Now we run the actual upgrade. By pointing to the same --cachedir, 
# pacman finds the 600+ packages we just verified/downloaded and 
# installs them instantly without further network usage.
pacman -Syu --noconfirm --cachedir "$PACACHE"

# 4. Ensure Project Dependencies are also cached and installed
# This ensures that even if the system is 'up to date', these specific 
# tools are present and their installers are stored in your PACACHE.
echo "--- Ensuring project dependencies are cached and installed ---"
pacman -S --needed --noconfirm --cachedir "$PACACHE" base-devel git wget unzip rsync

echo "--- Pacman setup and upgrade complete ---"

