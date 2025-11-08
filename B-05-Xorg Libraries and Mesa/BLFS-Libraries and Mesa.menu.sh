#!/bin/bash

source /root/lfs/USB/userID.key  # Access Keys
source /root/lfs/lib/menu.lib   # In every script.

cd "/root/lfs/B-05-Xorg Libraries and Mesa"

Menu_Pre_Render() {
	clear
	echo " "
	echo " "
	echo "     BLFS Xorg Libraries and Mesa"
	echo "     X Windows System Build"
	echo " "
}

main() {
	menu_setup "$HERE/BLFS-Libraries and Mesa.menu.tsv"
	menu_load
	check_auto
	menu_run
	menu_save
}

Menu_Post_Render() {
	echoL "Xorg Libraries and Mesa"
	echoR "BLFS X Windows Build"
	return 1
}

blfsSPIRVHeaders143210() {
	echoL "SPIRV-Headers (1.4.321.0)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
		return_wait 1
	return 1
}

blfsSPIRVTools143210() {
	echoL "SPIRV-Tools (1.4.321.0)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsLLVM2018() {
	echoL "LLVM (20.1.8)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsFontconfig2171() {
	echoL "Fontconfig (2.17.1)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsXorgLibraries() {
	echoL "Xorg Libraries"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsLibdrm24125() {
	echoL "Libdrm (2.4.125)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsSPIRVLLVMTrans2015() {
	echoL "SPIRV-LLVM-Translator (20.1.5)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}


blfsRustc1890() {
	echoL "Rustc (1.89.0)"
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
