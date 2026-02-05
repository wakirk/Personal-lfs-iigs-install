#!/bin/bash

cd /home/lfs/lfs
source lib/menu.lib
cd 1.03-Cross-Toolchain

Menu_Pre_Render() {
	clear
	echo " "
	echo " "
	echo "     Build System Software"
	echo " "
}

main() {
	menu_setup $HERE/Cross-Toolchain.menu.tsv
	menu_load
	check_auto
	menu_run
	menu_save
}

Menu_Post_Render() {
	echoL "Main Menu"
	echoR "System Software"
	return 1
}

BinutilsPass1() {
	echoL "Binutils-2.45 Pass 1"
#	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
#	root_share_on
	return_wait 1
	return 1
}

GCCPass1() {
	echoL "GCC-15.2.0 Pass 1"
#	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
#	root_share_on
	return_wait 1
	return 1
}

LinuxHeaders() {
	echoL "Linux-6.16.1 API Headers"
#	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
#	root_share_on
	return_wait 1
	return 1
}

Glibc () {
	echoL "Glibc-2.42"
#	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
#	root_share_on
	return_wait 1
	return 1
}

Libstdc() {
	echoL "Libstdc++ from GCC-15.2.0"
#	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
#	root_share_on
	return_wait 1
	return 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 0
