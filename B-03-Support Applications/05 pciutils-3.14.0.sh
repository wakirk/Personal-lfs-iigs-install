#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# pciutils Dependencies
	# Recommended
	#	hwdata-0.398 (runtime)

main () {

	# Download (HTTP): https://mj.ucw.cz/download/linux/pci/pciutils-3.14.0.tar.gz
	# Download MD5 sum: f70cf2da9377cb484802e291ea60115d
	# Download size: 708 KB
	# Estimated disk space required: 5.4 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 3 Support Applications"

	echoL "Downloading pciutils (3.14.0)..."
	sleep 2
	cd "/root/lfs/B-03-Support Applications"
	../bash/Download.sh https://mj.ucw.cz/download/linux/pci/pciutils-3.14.0.tar.gz pciutils-3.14.0.tar.gz
	cp ../Packages/pciutils-3.14.0.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack pciutils (3.14.0)..."
	sleep 2
	cd /sources
	rm -fR pciutils-3.14.0
	tar -vxsf pciutils-3.14.0.tar.gz
	cd pciutils-3.14.0

	echoL "Building pciutils (3.14.0)..."
	sleep 2
	sed -r '/INSTALL/{/PCI_IDS|update-pciids /d; s/update-pciids.8//}' -i Makefile
	make PREFIX=/usr SHAREDIR=/usr/share/hwdata SHARED=yes
	read

	echoL "Installing pciutils (3.14.0)..."
	sleep 2
	make PREFIX=/usr SHAREDIR=/usr/share/hwdata SHARED=yes install install-lib
	chmod -v 755 /usr/lib/libpci.so
	read

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR pciutils-3.14.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
