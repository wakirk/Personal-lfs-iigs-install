#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

#"$HERE/$EXEC_SCRIPT"
# Manual callback return mapping (applied after a manual selection):
#   0 => no change
#   1 => mark complete ('*')
#   2 => mark incomplete (' ')
#   3 => mark error ('E')
#
# U-loop callback return mapping (applied during U run):
#   0 => mark complete ('*')
#   1 => mark complete ('*')
#   2 => mark incomplete (' ') and continue to next
#   3 => mark error ('E') and STOP the loop

#test_func() {
#    echo "Test Function  1 called with $HERE."
#    echo "script to execute: $EXEC_SCRIPT"
#	if [ "$AUTO_RUNNING" -eq 1 ]; then
#		"$HERE/$EXEC_SCRIPT" --auto
#		read
#		rc=$?
#	else
#		"$HERE/$EXEC_SCRIPT"
#		rc=$?
#	fi
#	case $rc in
#		0) return 1 ;;   # complete (*)
#		2) return 2 ;;   # incomplete ( )
#		3) return 3 ;;   # error (E)
#		*) return 3 ;;   # anything else => error
#	esac
#}
#Menu_Select_1() {
#	echoL "Running step 1..."
#	echoR "LFS Setup"
#	return 0
#}

Menu_Pre_Render() {
	clear
	echo " "
	echo " "
	echo " "
	echo "                        ██╗     ███████╗███████╗   ███████╗███████╗████████╗██╗   ██╗██████╗ "
	echo "                        ██║     ██╔════╝██╔════╝   ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗"
	echo "                        ██║     █████╗  ███████╗   ███████╗█████╗     ██║   ██║   ██║██████╔╝"
	echo "                        ██║     ██╔══╝  ╚════██║   ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ "
	echo "                        ███████╗██║     ███████╗   ███████║███████║   ██║   ╚██████╔╝██║     "
	echo "                        ╚══════╝╚═╝     ╚══════╝   ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     "
	echo " "
	echo " "
}

Menu_Post_Render() {
	echoL "Main Menu"
	echoR "LFS Setup"
	return 1
}

sys_host_setup() {
	echo "Updating Host System Software"
	"$HERE/1.01-Host/$EXEC_SCRIPT"
	echo "Updating Host System Software Complete"
#	return_wait
	return 1
}

sys_preparing() {
	echo "Preparing the Host System for Build"
	"$HERE/1.02-Preparing/$EXEC_SCRIPT"
	echo "Preparing the Host System for Build Complete"
	return 1
}

lfs_Cross_Toolchain () {
	echo "Compiling a Cross-Toolchain"
	"$HERE/1.03-Cross-Toolchain/$EXEC_SCRIPT"
	echo "Compiling a Cross-Toolchain Complete"
	return 1
}

lfs_Cross_TempTools() {
	echo "Cross Compiling Temporary Tools"
	"$HERE/1.04-XCompilingTempTools/$EXEC_SCRIPT"
	echo "Cross Compiling Temporary Tools Complete"
	return 1
}

lfs_Cross_adddon_tempTools() {
	echo "Entering Chroot and Building Additional Temporary Tools"
	"$HERE/1.05-Chroot-Addon-TempTools/$EXEC_SCRIPT"
	echo "Entering Chroot and Building Additional Temporary Tools Complete"
	return 1
}

lfs_System_Software () {
	echo "Installing Basic System Software"
	"$HERE/1.06-Install-System-Software/$EXEC_SCRIPT"
	echo "Installing Basic System Software Complete"
	return 1
}

lfs_System_Config () {
	echo "System Configuration"
	"$HERE/1.07-System-Config/$EXEC_SCRIPT"
	echo "System Configuration Complete"
	return 1
}

BLFSLibraryFoundation () {
	echo "BLFS Library Foundation"
	"$HERE/B-01-Library Foundation/$EXEC_SCRIPT"
	echo "BLFS Library Foundation Complete"
	return 1
}

BLFSSupportLibrary () {
	echo "BLFS Support Library"
	"$HERE/B-02-Support Library/$EXEC_SCRIPT"
	echo "BLFS Support Library Complete"
	return 1
}

BLFSSupportApplications () {
	echo "BLFS Support Applications"
	"$HERE/B-03-Support Applications/$EXEC_SCRIPT"
	echo "BLFS Support Applications Complete"
	return 1
}


main() {
	export LFS=/mnt/lfs
	umask 022
	menu_setup $HERE/lfs-setup.tsv
	menu_load
	echoL "Test Left"
	echoR "Test Right"
	menu_run
	menu_save
}

# call_bash  Starts a pre-configured prompt.
lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
