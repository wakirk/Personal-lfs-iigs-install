#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {
	echoL "EFI Setup"
	echoR "System Software"
	sleep 2
	cd /sources

	mountpoint /sys/firmware/efi/efivars || mount -v -t efivarfs efivarfs /sys/firmware/efi/efivars
	cat >> /etc/fstab << EOF
efivarfs /sys/firmware/efi/efivars efivarfs defaults 0 0
EOF
	grub-install --bootloader-id=LFS --recheck
	cat > /boot/grub/grub.cfg << EOF
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod part_gpt
insmod ext2
set root=(hd0,2)

insmod efi_gop
insmod efi_uga
if loadfont /boot/grub/fonts/unicode.pf2; then
  terminal_output gfxterm
fi

menuentry "GNU/Linux, Linux 6.16.1-lfs-12.4" {
  linux   /boot/vmlinuz-6.16.1-lfs-12.4 root=/dev/nvme0n1p2 ro
}

menuentry "Firmware Setup" {
  fwsetup
}
EOF
	echoL "Exiting..."
	sleep 2
}
echo 12.4 > /etc/lfs-release
cat > /etc/lsb-release << "EOF"
DISTRIB_ID="Linux From Scratch"
DISTRIB_RELEASE="12.4"
DISTRIB_CODENAME="<your name here>"
DISTRIB_DESCRIPTION="Linux From Scratch"
EOF
cat > /etc/os-release << "EOF"
NAME="Linux From Scratch"
VERSION="12.4"
ID=lfs
PRETTY_NAME="Linux From Scratch 12.4"
VERSION_CODENAME="<your name here>"
HOME_URL="https://www.linuxfromscratch.org/lfs/"
RELEASE_TYPE="stable"
EOF

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
