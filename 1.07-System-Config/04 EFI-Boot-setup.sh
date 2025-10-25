#!/bin/bash

#Here is my script, don't worry about the lead-in and lead-out, main() is where the work is.

#/dev/nvme0n1p2 is where /mnt/lfs is mounted and will be / (root)
#as you said, we need to start via uuid.

#after /boot/grub/grub.cfg is written, we need to identify the needed information for the /dev/nvme0n1p2 partition
#and edit grub.cfg to boot to it. 


source /root/lfs/lib/menu.lib   # In every script.

main () {
	echoL "EFI Setup"
	echoR "System Software"
	sleep 2
	cd /sources

	mountpoint /sys/firmware/efi/efivars || mount -v -t efivarfs efivarfs /sys/firmware/efi/efivars

	grub-install --bootloader-id=LFS --recheck

#--------------------------------------------------------------------------

# Devices (as you had them)
ROOT=/dev/nvme0n1p2
EFI=/dev/nvme0n1p1
SWAP=/dev/nvme0n1p3

# IDs (PARTUUID + FS UUIDs, but we’ll WRITE using PARTUUID exactly like your templates)
ROOT_PARTUUID=$(blkid -s PARTUUID -o value "$ROOT")
EFI_PARTUUID=$(blkid  -s PARTUUID -o value "$EFI")
SWAP_PARTUUID=$(blkid -s PARTUUID -o value "$SWAP")

# (Optional) show exactly what will be inserted
echo "ROOT=$ROOT  PARTUUID=$ROOT_PARTUUID"
echo "EFI=$EFI    PARTUUID=$EFI_PARTUUID"
echo "SWAP=$SWAP  PARTUUID=$SWAP_PARTUUID"

# ---------------------------
# /boot/grub/grub.cfg (your style)
# ---------------------------
cat > /boot/grub/grub.cfg <<EOF
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod part_gpt
search --no-floppy --partuuid --set=root $ROOT_PARTUUID
insmod ext2
insmod efi_gop
insmod efi_uga
if loadfont /boot/grub/fonts/unicode.pf2; then
  terminal_output gfxterm
fi
insmod gfxterm
set gfxmode=800x600
set gfxpayload=keep     # hand off 800x600 to the kernel


menuentry "GNU/Linux, Linux 6.16.1-lfs-12.4" {
  linux /boot/vmlinuz-6.16.1-lfs-12.4 root=PARTUUID=$ROOT_PARTUUID rootfstype=ext4 ro console=tty1 video=800x600
}

menuentry "Firmware Setup" {
  fwsetup
}
EOF

# ---------------------------
# /mnt/lfs/etc/fstab (your style: PARTUUID for all three)
# ---------------------------
cat > /etc/fstab << EOF
# <fs>                                               <mount>       <type>   <opts>                  <dump> <pass>
PARTUUID=$ROOT_PARTUUID        /              ext4      defaults                0      0
PARTUUID=$EFI_PARTUUID        /boot/efi      vfat      umask=0077              0      0
PARTUUID=$SWAP_PARTUUID        none           swap      pri=1                   0      0
proc                                                 /proc          proc      nosuid,noexec,nodev     0      0
sysfs                                                /sys           sysfs     nosuid,noexec,nodev     0      0
devpts                                               /dev/pts       devpts    gid=5,mode=620          0      0
tmpfs                                                /run           tmpfs     mode=0755,nosuid,nodev  0      0
tmpfs                                                /dev/shm       tmpfs     mode=1776,nosuid,nodev  0      0
cgroup2                                              /sys/fs/cgroup cgroup2   defaults                0      0
efivarfs                                  /sys/firmware/efi/efivars efivarfs  defaults                0      0
EOF


	clear
	cat /boot/grub/grub.cfg
	sleep 10
	clear
	cat /etc/fstab
	sleep 10
	echoL "Exiting..."
	sleep 2

}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
