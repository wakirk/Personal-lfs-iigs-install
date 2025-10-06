#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {
	clear
	echoR "Installing Software"
	echoL "Testing Enviornment"
	bash
	chroot_shell
	echo "Exiting..."
	exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
