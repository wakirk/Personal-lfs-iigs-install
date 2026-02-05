#!/bin/bash

cd /home/lfs/lfs
source lib/menu.lib
cd 1.01-Host

setupClock() {
	echoL "Set Clock"
	"$HERE/$EXEC_SCRIPT"
	return_wait
	return 1
}

setupPacman() {
	echoL "Configure Pacman and Update System"
	"$HERE/$EXEC_SCRIPT"
	return_wait
	return 1
}

setupDevsw() {
	echoL "Install Dev Software"
	"$HERE/$EXEC_SCRIPT"
	return_wait
	return 1
}

setupQEMU() {
	echoL "QEMU Setup"
	"$HERE/$EXEC_SCRIPT"
	return_wait
	return 1
}

setupVcheck() {
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
