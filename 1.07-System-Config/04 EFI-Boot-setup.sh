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

	cat >> /etc/fstab << EOF
efivarfs /sys/firmware/efi/efivars efivarfs defaults 0 0
EOF

	grub-install --bootloader-id=LFS --recheck

	cat > /boot/grub/grub.cfg << EOF
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod part_gpt
search --no-floppy --partuuid --set=root 7b746c25-683b-41ba-b41d-42e98fdca251
insmod ext2

insmod efi_gop
insmod efi_uga
if loadfont /boot/grub/fonts/unicode.pf2; then
  terminal_output gfxterm
fi

menuentry "GNU/Linux, Linux 6.16.1-lfs-12.4" {
  linux /boot/vmlinuz-6.16.1-lfs-12.4 root=PARTUUID=7b746c25-683b-41ba-b41d-42e98fdca251 rootfstype=ext4 rw
}

menuentry "Firmware Setup" {
  fwsetup
}
EOF
#>>>>
#	# GPT ONLY ALLOWED TO EDIT HERE

#	GRUBCFG="/boot/grub/grub.cfg"

#	# Figure out the devices/filesystems for / and for the file that holds grub.cfg
#	ROOT_DEV="$(findmnt -no SOURCE /)"
#	BOOT_DEV="$(findmnt -no SOURCE -T "$GRUBCFG")"

#	# Pull filesystem UUIDs (NOT disk GUIDs)
#	ROOT_UUID="$(blkid -s UUID -o value "$ROOT_DEV" 2>/dev/null)"
#	BOOT_UUID="$(blkid -s UUID -o value "$BOOT_DEV" 2>/dev/null)"

#	if [ -z "$ROOT_UUID" ] || [ -z "$BOOT_UUID" ]; then
#		echo "ERROR: Could not determine UUIDs. ROOT_UUID='$ROOT_UUID' BOOT_UUID='$BOOT_UUID'" >&2
#		/bin/bash
#	fi

#	# Backup once
#	cp -f "$GRUBCFG" "$GRUBCFG.bak.$(date +%Y%m%d-%H%M%S)" || return 1

#	# 1) Ensure GRUB locates the FS that holds /boot/grub/grub.cfg
#	#    Replace any existing search --fs-uuid UUID with the BOOT_UUID (all occurrences)
#	sed -i -E "s#(search[[:space:]].*--fs-uuid[[:space:]]+)[A-Fa-f0-9-]{8,}#\1$BOOT_UUID#g" "$GRUBCFG"

#	#    If no search --fs-uuid exists, insert one just after the first 'insmod' line
#	if ! grep -Eq '^[[:space:]]*search[[:space:]].*--fs-uuid[[:space:]].*--set=root' "$GRUBCFG"; then
#		awk -v uuid="$BOOT_UUID" '
 #     BEGIN{ins=0}
  #    {print}
#      ins==0 && /^ *insmod[[:space:]]/ { print "search --no-floppy --fs-uuid --set=root " uuid; ins=1 }
#    ' "$GRUBCFG" > "$GRUBCFG.tmp" && mv -f "$GRUBCFG.tmp" "$GRUBCFG"
#	fi

	# 2) Point the kernel at the ROOT filesystem (/) by UUID and force rw
	#    Replace any existing root=... (UUID/PARTUUID/LABEL or /dev/...) with ROOT_UUID
#	sed -i -E "s#\broot=(UUID|PARTUUID|LABEL|/dev/[[:alnum:]/._-]+)=[^[:space:]]+#root=UUID=$ROOT_UUID#g" "$GRUBCFG"

	#    If a linux/linuxefi line lacks root= entirely, append it (plus rw)
#	if ! grep -Eq '^[[:space:]]*linux(efi)?[[:space:]].*\broot=' "$GRUBCFG"; then
#		sed -i -E "s#^([[:space:]]*linux(efi)?[[:space:]][^$]*)#\1 root=UUID=$ROOT_UUID rw#" "$GRUBCFG"
#	fi

#	#    Ensure we boot rw (flip any trailing ' ro' to ' rw')
#	sed -i -E 's/[[:space:]]ro(\s|$)/ rw\1/g' "$GRUBCFG"

#	echo "GRUB updated: BOOT_UUID=$BOOT_UUID (for search), ROOT_UUID=$ROOT_UUID (for root=) and rw enforced."
	#<<<<	echo 12.4 > /etc/lfs-release

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
	cat /boot/grub/grub.cfg
	/bin/bash
	echoL "Exiting..."
	sleep 2

}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
