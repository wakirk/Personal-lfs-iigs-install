#!/bin/bash

source /root/lfs/USB/userID.key  # Access Keys
source /root/lfs/lib/menu.lib   # In every script.
cd /root/lfs/1.07-System-Config

Menu_Pre_Render() {
	clear
	echo " "
	echo " "
	echo "     System Configuraiton"
	echo " "
}

main() {
	menu_setup $HERE/System-Config.menu.tsv
	menu_load
	check_auto
	menu_run
	menu_save
}

Menu_Post_Render() {
	echoL "System Configuration"
	echoR "Install"
	return 1
}

stripping() {
	echoL "Stripping"
	echoR "System Configuration"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

postCleanup() {
	echoL "Cleaning up..."
	echoR "System Configuration"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

lfsbootscripts() {
	echoL "LFS Boot Scripts"
	echoR "System Configuration"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

linux616() {
	echoL "Linux (6.16.1)"
	echoR "System Configuration"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

efiboot() {
	echoL "EFI Boot Configuration"
	echoR "System Configuration"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

OSconfig() {
	echoL "System OS Configuration"
	echoR "System Configuration"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldFUSE() {
	echoL "FUSE Filesystem Tools"
	echoR "System Configuration"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldTerminusfont() {
	echoL "Terminus Font (4.49.1)"
	echoR "System Configuration"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
