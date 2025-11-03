#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

# libpsl Dependencies
# Recommended
# 	libidn2-2.3.8
# 	libunistring-1.3

# Optional
# 	GTK-Doc-1.34.0 (for documentation)
# 	ICU-77.1 (may be used instead of libidn2)
# 	libidn-1.43 (may be used instead of libidn2), 
# 	Valgrind-3.25.1 (for tests)

main () {

	# Download (HTTP): https://github.com/rockdaboot/libpsl/releases/download/0.21.5/libpsl-0.21.5.tar.gz
	# Download MD5 sum: 870a798ee9860b6e77896548428dba7b
	# Download size: 7.3 MB
	# Estimated disk space required: 50 MB
	# Estimated build time: less than 0.1 SBU (including tests)
	echoR "Group 2 Support Library"

	echoL "Downloading libpsl (0.21.5)..."
	sleep 2
	cd "/root/lfs/B-02-Support Library"
	../bash/Download.sh https://github.com/rockdaboot/libpsl/releases/download/0.21.5/libpsl-0.21.5.tar.gz libpsl-0.21.5.tar.gz
	cp ../Packages/libpsl-0.21.5.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libpsl (0.21.5)..."
	sleep 2
	cd /sources
	rm -fR libpsl-0.21.5
	tar -vxsf libpsl-0.21.5.tar.gz
	cd libpsl-0.21.5

	echoL "Building libpsl (0.21.5)..."
	sleep 2
	mkdir build
	cd    build
	meson setup --prefix=/usr --buildtype=release
	ninja
	read

	echoL "Testomg libpsl (0.21.5)..."
	sleep 2
	ninja test
	read

	echoL "Installing libpsl (0.21.5)..."
	sleep 2
	ninja install
	read

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libpsl-0.21.5

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
