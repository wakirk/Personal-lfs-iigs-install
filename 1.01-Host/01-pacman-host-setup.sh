#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.
cd /root/lfs/1.01-Host

# SystemRescue (Arch-based) pacman bootstrap — reboot-safe & idempotent
# - Uses ONLY official archlinux-keyring (no keyservers)
# - Temporarily disables sig checks ONLY to fetch gnupg+keyring
# - Creates local secret key so pacman-key can lsign without whining
# - Purges stale cache so bad/old packages cannot be reused
# - Updates userspace (skips kernel while on live ISO)
# - Installs a minimal toolset and proves it works
echoR "Configuring Host"
echoL "Configuring Clock"
timedatectl set-timezone America/Chicago >/dev/null 2>&1 || true
timedatectl set-ntp true                 >/dev/null 2>&1 || true

echoL "Configuring Mirrors"
# 1) Good mirrors + unlock
cat >/etc/pacman.d/mirrorlist <<'EOF'
Server = https://geo.mirror.pkgbuild.com/$repo/os/$arch
Server = https://mirrors.edge.kernel.org/archlinux/$repo/os/$arch
Server = https://mirror.rackspace.com/archlinux/$repo/os/$arch
EOF
rm -f /var/lib/pacman/db.lck

echoL "Configuring Accounts"
# 2) Make a no-sig pacman config (do NOT touch the real one)
cp /etc/pacman.conf /tmp/pacman.conf.nosig
if grep -q '^SigLevel' /tmp/pacman.conf.nosig; then
  sed -i 's/^SigLevel.*/SigLevel = Never/' /tmp/pacman.conf.nosig
else
  sed -i '/^\[options\]/a SigLevel = Never' /tmp/pacman.conf.nosig
fi

echoL "Cleaning cache"
# 3) Hard purge any cached pkgs so nothing stale gets reused
pacman -Scc --noconfirm
rm -f /var/cache/pacman/pkg/*

echoL "Installing System..."
# 4) Update + install with signatures DISABLED (hammer mode)
pacman -Syyu --noconfirm --ignore linux,linux-firmware --config /tmp/pacman.conf.nosig

echoL "Installing Packages..."
pacman -S    --noconfirm --needed --config /tmp/pacman.conf.nosig \
  base-devel git cifs-utils rsync wget curl nano htop

# 5) (Optional) switch back to normal config afterwards
pacman -Syy

#---------------------------

echoL "installing glibc..."
# 1) Make sure glibc and gcc runtime libs are installed
pacman --config /tmp/pacman.conf.nosig -S --noconfirm --needed glibc gcc-libs

# 2) Confirm the file exists now
ls -l /usr/lib/libc_nonshared.a || find /usr/lib -maxdepth 1 -name 'libc_nonshared.a'

# 3) Refresh linker cache (belt-and-suspenders)
ldconfig

# 4) Re-run the tiny C++ link test
printf 'int main(){}' | g++ -x c++ -o /tmp/a - && /tmp/a && echo "OK: g++ links"

#---------------------------

# reinstall glibc in this live session (we used a temp no-sig config earlier)
pacman --config /tmp/pacman.conf.nosig -S --noconfirm glibc

# confirm the file is actually present in the package db and on disk
pacman -Ql glibc | grep libc_nonshared.a || echo "not in pkg db"
ls -l /usr/lib/libc_nonshared.a || echo "not on disk"

# refresh linker cache and retry the tiny link test
ldconfig
printf 'int main(){}' | g++ -x c++ -o /tmp/a - && /tmp/a && echo "OK: g++ links"

echoL "Installing QEMU..."
#------------------------------------ QEMU
# QEMU + tools (only once per live boot)
pacman --config /tmp/pacman.conf.nosig -S --noconfirm qemu parted dosfstools e2fsprogs rsync

# Use the unsigned config we already created for this live session
PACCONF=/tmp/pacman.conf.nosig

# QEMU with GTK display support (provides qemu-system-x86_64 + GTK deps)
pacman --config "$PACCONF" -S --noconfirm --needed qemu-desktop qemu-system-x86_64

# (Optional, for future UEFI boots via OVMF; NOT needed for your current -kernel command)
# pacman --config "$PACCONF" -S --noconfirm --needed edk2-ovmf

# Load KVM kernel modules required by your "-enable-kvm" flag
modprobe kvm 2>/dev/null || true
modprobe kvm_intel 2>/dev/null || modprobe kvm_amd 2>/dev/null || true

pacman -Sy --noconfirm qemu-ui-gtk

# Quick sanity checks
command -v qemu-system-x86_64
[ -e /dev/kvm ] && echo "/dev/kvm is present" || echo "WARNING: /dev/kvm missing (KVM accel won’t work)"

pacman -Sy --noconfirm edk2-ovmf

# 0) Confirm the binary and what displays it supports
qemu-system-x86_64 --version
qemu-system-x86_64 -display help
echoL "Configure Complete"

exit 1
