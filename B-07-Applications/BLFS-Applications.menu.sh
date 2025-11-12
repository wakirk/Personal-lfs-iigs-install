#!/bin/bash

source /root/lfs/USB/userID.key  # Access Keys
source /root/lfs/lib/menu.lib   # In every script.

cd "/root/lfs/B-07-Applications"

Menu_Pre_Render() {
	clear
	echo " "
	echo " "
	echo "     BLFS Applications"
	echo "     X Windows System Build"
	echo " "
}

main() {
	menu_setup "$HERE/BLFS-Applications.menu.tsv"
	menu_load
	check_auto
	menu_run
	menu_save
}

Menu_Post_Render() {
	echoL "Applications"
	echoR "BLFS Appliations Build"
	return 1
}

blfsxinit144() {
	echoL "xinit (1.4.4)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsxterm401() {
	echoL "xterm (401)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfstwm10131() {
	echoL "twm (1.0.13.1)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

#	export XORG_PREFIX="/usr"
#	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
