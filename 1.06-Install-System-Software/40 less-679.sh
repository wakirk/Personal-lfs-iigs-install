#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Less (679) - 857 KB:
	# Home page: https://www.greenwoodsoftware.com/less/
	# Download: https://www.greenwoodsoftware.com/less/less-679.tar.gz
	# MD5 sum: 0386dc14f6a081a94dfb4c2413864eed
	echoR "System Software"

	echoL "Downloading Less (679)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://www.greenwoodsoftware.com/less/less-679.tar.gz less-679.tar.gz
	cp ../Packages/less-679.tar.gz /sources

	echoL "Unpack Less (679)..."
	sleep 2
	cd /sources
	rm -fR less-679
	tar -vxsf less-679.tar.gz
	cd less-679

	echoL "Building Less (679)..."
	sleep 2
	./configure --prefix=/usr --sysconfdir=/etc
	make

	echoL "Testing Less (679)..."
	sleep 2
	make check

	echoL "Installing Less (679)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR less-679

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
