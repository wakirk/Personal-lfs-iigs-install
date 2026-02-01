#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.
cd /root/lfs/1.02-Preparing

Menu_Pre_Render() {
	clear
	echo " "
	echo " "
	echo "     Preparing for the Build"
	echo " "
}

main() {
	menu_setup $HERE/Preparing.menu.tsv
	menu_load
	check_auto
	menu_run
	menu_save
}

Menu_Post_Render() {
	echoL "Main Menu"
	echoR "Prepare Host"
	return 1
}

prep_wipedisk() {
	# 00-clean-partition.sh	Clean Partitions (CAUTION)
	echoL "Clean Partitions"
	"$HERE/$EXEC_SCRIPT"
	return_wait 1
	return 1
}

prep_newparts() {
	# 10-NewPartition.sh	New Partitions (CAUTION)
	echoL "New Partitions"
	"$HERE/$EXEC_SCRIPT"
	return_wait 1
	return 1
}

prep_mklfsfs() {
	# 20-FileSystem.sh	Create LFS File systems (CAUTION)
	echoL "Create LFS File systems"
	"$HERE/$EXEC_SCRIPT"
	return_wait 1
	return 1
}

prep_mountlfs() {
	# 30-MountingSystem.sh	Mount LFS File system
	echoL "Mount LFS File system"
	"$HERE/$EXEC_SCRIPT"
	return_wait 1
	return 1
}

prep_initdirs() {
	# 40-Inital-dirs.sh	Create Initial Directories
	echoL "Create Initial Directories"
	"$HERE/$EXEC_SCRIPT"
	return_wait 1
	return 1
}

prep_environ() {
	# 40-Inital-dirs.sh	Create Initial Directories
	echoL "Configure Build Environment"
	"$HERE/$EXEC_SCRIPT"
	return_wait 1
	return 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
