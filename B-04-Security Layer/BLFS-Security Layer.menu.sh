#!/bin/bash

source /root/lfs/USB/userID.key  # Access Keys
source /root/lfs/lib/menu.lib   # In every script.

cd /root/lfs/B-04-Security Layer

Menu_Pre_Render() {
	clear
	echo " "
	echo " "
	echo "     BLFS Security Layer"
	echo "     X Windows System Build"
	echo " "
}

main() {
	menu_setup "$HERE/BLFS-Security Layer.menu.tsv"
	menu_load
	check_auto
	menu_run
	menu_save
}

Menu_Post_Render() {
	echoL "Security Layer"
	echoR "BLFS X Windows Build"
	return 1
}

blfsWget1250() {
	echoL "Wget (1.25.0)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsxcbutil041() {
	echoL "xcb-util (0.4.1)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfslibpwquality145() {
	echoL "libpwquality (1.4.5)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsLinuxPAM171() {
	echoL "Linux-PAM (1.7.1)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsShadow4180() {
	echoL "Shadow (4.18.0)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfslibxslt1143() {
	echoL "libxslt (1.1.43)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsdocutils0212() {
	echoL "docutils (0.21.2)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsGLib2844Pass1() {
	echoL "GLib (2.84.4) Pass 1"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsdesktopfileutils028() {
	echoL "Desktop File-utils (0.28)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfssharedmimeinfo24() {
	echoL "shared mime info (2.4)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

GLib2844Pass2() {
	echoL "GLib (2.84.4) Pass 2"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsFreeType2133Pass1() {
	echoL "FreeType (2.13.3) Pass 1"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsharfBuzz1141() {
	echoL "harfBuzz (11.4.1)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsFreeType2133Pass2() {
	echoL "FreeType (2.13.3) Pass 2"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsSudo1917p2() {
	echoL "Sudo (1.9.17p2)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsOpenSSH100p1() {
	echoL "OpenSSH (10.0p1)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfslibssh21111() {
	echoL "libssh2 (1.11.1)"
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
