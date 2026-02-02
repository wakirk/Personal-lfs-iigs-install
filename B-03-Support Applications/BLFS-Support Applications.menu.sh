#!/bin/bash

source /root/lfs/USB/userID.key  # Access Keys
source /root/lfs/lib/menu.lib   # In every script.

cd /root/lfs/B-03-Support Applications

Menu_Pre_Render() {
	clear
	echo " "
	echo " "
	echo "     BLFS Support Applications"
	echo "     X Windows System Build"
	echo " "
}

main() {
	menu_setup "$HERE/BLFS-Support Applications.menu.tsv"
	menu_load
	check_auto
	menu_run
	menu_save
}

Menu_Post_Render() {
	echoL "Support Applications"
	echoR "BLFS X Windows Build"
	return 1
}

blfsdocbookxml45() {
	echoL "docbook-xml (4.5)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsdocbookxslnons1792() {
	echoL "docbook-xsl-nons (1.79.2)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsGnuTLS3810() {
	echoL "GnuTLS (3.8.10)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsxbitmaps113() {
	echoL "xbitmaps (1.1.3)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfspciutils3140() {
	echoL "pciutils (3.14.0)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfshwdata0398() {
	echoL "hwdata (0.398) Support Reinstall"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsnghttp21660() {
	echoL "nghttp2 (1.66.0)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfscURL8150() {
	echoL "cURL (8.15.0)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsGit2501() {
	echoL "Git (2.50.1)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsCMake410() {
	echoL "CMake (4.1.0)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsxorgproto20241() {
	echoL "xorgproto (2024.1)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfslibXdmcp115() {
	echoL "libXdmcp (1.1.5)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfslibXau1012() {
	echoL "libXau (1.0.12)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfslibxcb1170() {
	echoL "libxcb (1.17.0)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfslibedit101631() {
	echoL "libedit (20251016-3.1)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsPCRE21045() {
	echoL "PCRE2 (10.45)"
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
