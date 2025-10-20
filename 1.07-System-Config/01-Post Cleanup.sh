#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {
	echoR "System Configuration"
	echoL "Stripping"
	df -h /dev/nvme0n1p2 > /root/tmp.ds

	rm -rf /tmp/{*,.*}
	find /usr/lib /usr/libexec -name \*.la -delete
	find /usr -depth -name $(uname -m)-lfs-linux-gnu\* | xargs rm -rf
	userdel -r tester
	df -h /dev/nvme0n1p2 >> /root/tmp.ds
	cat /root/tmp.ds
	sleep 10
	rm /root/tmp.ds
	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
