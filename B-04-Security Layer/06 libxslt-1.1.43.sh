#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# 06 libxslt-1.1.43.sh
	# https://www.linuxfromscratch.org/blfs/view/stable/general/libxslt.html

	# Required
	# libxml2-2.14.5

	# Recommended (at runtime)
	# docbook-xml-4.5
	# docbook-xsl-nons-1.79.2

	# Optional
	# libgcrypt-1.11.2 (only needed for the deprecated EXSLT crypto extension, see Command Explanations)

main () {

	# Download (HTTP): https://download.gnome.org/sources/libxslt/1.1/libxslt-1.1.43.tar.xz
	# Download MD5 sum: 5dc0179c81be7a3082b43030ecfdebd4
	# Download size: 1.5 MB
	# Estimated disk space required: 33 MB (with tests)
	# Estimated build time: 0.2 SBU (with tests)
	echoR "Group 4 Security Layer"

	echoL "Downloading libxslt (1.1.43)..."
	sleep 2
	cd "/root/lfs/B-04-Security Layer"
	../bash/Download.sh https://download.gnome.org/sources/libxslt/1.1/libxslt-1.1.43.tar.xz libxslt-1.1.43.tar.xz
	cp ../Packages/libxslt-1.1.43.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libxslt (1.1.43)..."
	sleep 2
	cd /sources
	rm -fR libxslt-1.1.43
	tar -vxsf libxslt-1.1.43.tar.xz
	cd libxslt-1.1.43

	echoL "Building libxslt (1.1.43)..."
	sleep 2
	./configure --prefix=/usr    \
				--disable-static \
				--docdir=/usr/share/doc/libxslt-1.1.43 &&
	make

	echoL "Testing libxslt (1.1.43)..."
	sleep 2
	make check

	echoL "Installing libxslt (1.1.43)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libxslt-1.1.43

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
