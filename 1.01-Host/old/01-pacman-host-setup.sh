#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.
cd /root/lfs/1.01-Host

echoR "Configuring Host"
echoL "Configuring Clock"
timedatectl set-timezone America/Chicago >/dev/null 2>&1 || true
timedatectl set-ntp true                 >/dev/null 2>&1 || true

echoL "Configuring Pacman...."
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

sed -i '/^\[options\]/a SigLevel = Never' /etc/pacman.conf
pacman -Syyu --noconfirm
pacman -S --noconfirm archlinux-keyring gnupg
sed -i 's/^SigLevel = Never/SigLevel = Required DatabaseOptional/' /etc/pacman.conf
pacman -Syyu --noconfirm


echoL "Installing Build System..."

# Core headers & toolchain
pacman -S --noconfirm --overwrite '/usr/include/linux/*' linux-api-headers
pacman -S --noconfirm gcc make patch glibc gcc-libs

# Parser/build tools required by LFS
pacman -S --noconfirm bison texinfo flex pkgconf

# Compression stacks (binutils BFD wants these headers)
pacman -S --noconfirm --overwrite '/usr/include/*' zstd zlib xz bzip2

# Optional system packages (only if you need them on the live host)
pacman -S --noconfirm linux linux-firmware
pacman -S --noconfirm parted dosfstools e2fsprogs rsync

# QEMU + OVMF (Arch package names; choose JACK provider to avoid prompt)
pacman -S --noconfirm libcbor libfido2 qemu-system-x86 qemu-desktop qemu-ui-gtk edk2-ovmf pipewire-jack
pacman -S --noconfirm fuse3

# Refresh linker cache (belt-and-suspenders)
ldconfig

# Load KVM kernel modules required by your "-enable-kvm" flag
modprobe kvm 2>/dev/null || true
modprobe kvm_intel 2>/dev/null || modprobe kvm_amd 2>/dev/null || true

printf '%s\n' '#!/bin/sh' 'exec bison -y "$@"' > /usr/bin/yacc
chmod +x /usr/bin/yacc

# Verify QEMU once (pkg is qemu-system-x86; binary is qemu-system-x86_64)
#command -v qemu-system-x86_64
#qemu-system-x86_64 --version
#qemu-system-x86_64 -display help

# Binary present + version OK (no GUI)
command -v qemu-system-x86_64
qemu-system-x86_64 --version
# Prove it runs without a display
#qemu-system-x86_64 --version
#qemu-system-x86_64 -display none -M none -S -qmp stdio -nodefaults -nographic -accel tcg <<< '{ "execute": "quit" }'

# Verify toolchain & headers (fast fail if anything missing)
command -v gcc g++ make bison texi2any flex yacc
ls -l /usr/include/linux/limits.h /usr/include/{zstd.h,zlib.h,lzma.h,bzlib.h}
ldd "$(command -v qemu-system-x86_64)" | awk '/not found/ {print}'

echoL "Configure Complete"
exit 1

