#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.
source /root/lfs/USB/userID.key  # Access Keys
export $SHARE, $SHARE_USER, $SHARE_PASS, $SHARE_VERS, $SHARE_ID
cd /root/lfs/1.04-XCompilingTempTools

Menu_Pre_Render() {
	clear
	echo " "
	echo " "
	echo "     Build System Software"
	echo " "
}

main() {
	menu_setup $HERE/XCompilingTempTools.tsv
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


M41420() {
	echoL "M4 1.4.20"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

Ncurses65() {
	echoL "Ncurses 6.5-20250809"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

Bash5() {
	echoL "Bash (5.3)"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

Coreutils9() {
	echoL "Coreutils (9.7)"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

Diffutils3() {
	echoL "Diffutils (3.12)"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

File5() {
	echoL "File (5.46)"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

Findutils4() {
	echoL "Findutils (4.10.0)"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

Gawk5() {
	echoL "Gawk (5.3.2)"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

Grep3() {
	echoL "Grep (3.12)"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

Gzip1() {
	echoL "Gzip (1.14)"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

Make4() {
	echoL "Make (4.4.1)"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

Patch2() {
	echoL "Patch (2.8)"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

Sed4() {
	echoL "Sed (4.9)"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

Tar1() {
	echoL "Tar (1.35)"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

Xz5() {
	echoL "Xz Utils (5.8.1)"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

Binutils2Pass2() {
	echoL "Binutils (2.45) Pass 2"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

GCC15Pass2() {
	echoL "GCC (15.2.0) Pass 2"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
