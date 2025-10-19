#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# IPRoute2 (6.16.0) - 910 KB:
	# Home page: https://www.kernel.org/pub/linux/utils/net/iproute2/
	# Download: https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.16.0.tar.xz
	# MD5 sum: 80e1f91bf59d572acc15d5c6eb4f3e7c
	echoR "System Software"

	echoL "Downloading IPRoute2 (6.16.0)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.16.0.tar.xz iproute2-6.16.0.tar.xz
	cp ../Packages/iproute2-6.16.0.tar.xz /sources

	echoL "Unpack IPRoute2 (6.16.0)..."
	sleep 2
	cd /sources
	rm -fR iproute2-6.16.0
	tar -vxsf iproute2-6.16.0.tar.xz
	cd iproute2-6.16.0

	echoL "Building IPRoute2 (6.16.0)..."
	sleep 2
	sed -i /ARPD/d Makefile
	rm -fv man/man8/arpd.8
	make NETNS_RUN_DIR=/run/netns

	echoL "Installing IPRoute2 (6.16.0)..."
	sleep 2
	make SBINDIR=/usr/sbin install
	install -vDm644 COPYING README* -t /usr/share/doc/iproute2-6.16.0

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR iproute2-6.16.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
