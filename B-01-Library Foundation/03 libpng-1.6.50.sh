#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Package Information libpng (1.6.50)
	# Download (HTTP): https://downloads.sourceforge.net/libpng/libpng-1.6.50.tar.xz
	# Download MD5 sum: e583e61455c4f40d565d85c0e9a2fbf9
	# Download size: 1.0 MB
	# Estimated disk space required: 14 SBU (with tests)
	# Estimated build time: 0.1 SBU (add 0.3 SBU for tests)
	# Additional Downloads
	# Recommended patch to include animated png functionality in libpng (required to use the system libpng in Firefox, Seamonkey, and Thunderbird): https://downloads.sourceforge.net/sourceforge/libpng-apng/libpng-1.6.47-apng.patch.gz
	# Patch md5sum: 5c4a639b227ac60a0e438840bcf1cf5f
	echoR "Group 1 Library Foundation"

	echoL "Downloading libpng (1.6.50)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://downloads.sourceforge.net/libpng/libpng-1.6.50.tar.xz libpng-1.6.50.tar.xz
	cp ../Packages/libpng-1.6.50.tar.xz /sources

	../bash/Download.sh https://downloads.sourceforge.net/sourceforge/libpng-apng/libpng-1.6.47-apng.patch.gz libpng-1.6.47-apng.patch.gz
	cp ../Packages/libpng-1.6.47-apng.patch.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libpng (1.6.50)..."
	sleep 2
	cd /sources
	rm -fR libpng-1.6.50
	tar -vxsf libpng-1.6.50.tar.xz
	cd libpng-1.6.50

	echoL "Building libpng (1.6.50)..."
	sleep 2
	gzip -cd ../libpng-1.6.47-apng.patch.gz | patch -p1
	./configure --prefix=/usr --disable-static
	make

	echoL "Testing libpng (1.6.50)..."
	make check.

	echoL "Installing libpng (1.6.50)..."
	sleep 2
	make install
	mkdir -v /usr/share/doc/libpng-1.6.50
	cp -v README libpng-manual.txt /usr/share/doc/libpng-1.6.50

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libpng-1.6.50

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
