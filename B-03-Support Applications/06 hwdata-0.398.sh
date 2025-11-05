#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://github.com/vcrhonek/hwdata/archive/v0.398/hwdata-0.398.tar.gz
	# Download MD5 sum: 1ce78576cdde13f0e1953445a98bf173
	# Download size: 2.4 MB
	# Estimated disk space required: 9.8 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 3 Support Applications"

	echoL "Downloading hwdata (0.398) Support Reinstall..."
	sleep 2
	cd "/root/lfs/B-03-Support Applications"
	../bash/Download.sh https://github.com/vcrhonek/hwdata/archive/v0.398/hwdata-0.398.tar.gz hwdata-0.398.tar.gz
	cp ../Packages/hwdata-0.398.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack hwdata (0.398) Support Reinstall..."
	sleep 2
	cd /sources
	rm -fR hwdata-0.398
	tar -vxsf hwdata-0.398.tar.gz
	cd hwdata-0.398

	echoL "Building hwdata (0.398) Support Reinstall..."
	sleep 2
	./configure --prefix=/usr --disable-blacklist

	echoL "Installing hwdata (0.398) Support Reinstall..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR hwdata-0.398

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
