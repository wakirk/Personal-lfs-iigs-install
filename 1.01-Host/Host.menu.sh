#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

host_setup() {
	echoL "Setting up Workspace"
	"$HERE/$EXEC_SCRIPT"
	return_wait
	return 1
}

qemu_setup() {
	echoL "Installing QEMU Emulator"
	"$HERE/$EXEC_SCRIPT"
	return_wait
	return 1
}

version_check() {
	echoL "Version Check"
	"$HERE/$EXEC_SCRIPT"
	return_wait
	return 1
}

Menu_Pre_Render() {
	clear
	echo " "
	echo " "
	echo "     Updating Host System Software"
	echo " "
}

Menu_Post_Render() {
	echoL "Main Menu"
	echoR "Host Setup"
	return 1
}

main() {
	menu_setup $HERE/Host.menu.tsv
	menu_load
	check_auto
	menu_run
	menu_save
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
