#!/bin/bash

source /root/lfs/USB/userID.key  # Access Keys
source /root/lfs/lib/menu.lib   # In every script.
cd /root/lfs/1.08-X-WindowsSystem

Menu_Pre_Render() {
	clear
	echo " "
	echo " "
	echo "     X Windows System"
	echo " "
}

main() {
	menu_setup $HERE/LFS-Bootable.menu.tsv
	menu_load
	check_auto
	menu_run
	menu_save
}

Menu_Post_Render() {
	echoL "Window System"
	echoR "X Windows"
	return 1
}

Winxorgproto() {
	echoL "xorgproto (2024.1)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}


WinlibXau() {
	echoL "libXau (1.0.12)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

WinlibXdmcp() {
	echoL "libXdmcp (1.1.5)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

Winxtrans() {
	echoL "xtrans (1.6.0)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}


lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
