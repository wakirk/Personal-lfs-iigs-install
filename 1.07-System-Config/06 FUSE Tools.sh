#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

 main () {

	# Fuse-3.17.4
	# Download (HTTP): https://github.com/libfuse/libfuse/releases/download/fuse-3.17.4/fuse-3.17.4.tar.gz
	# Download MD5 sum: c894181418bf0bc11f98938fc30d37df
	# Download size: 7.0 MB
	# Estimated disk space required: 100 MB (with tests and documentation)
	# Estimated build time: 0.1 SBU (add 0.4 SBU for tests)
	echoR "System Software"

	echoL "Downloading Fuse (3.17.4)..."
	sleep 2
	cd "/root/lfs/1.07-System-Config"
	../bash/Download.sh https://github.com/libfuse/libfuse/releases/download/fuse-3.17.4/fuse-3.17.4.tar.gz fuse-3.17.4.tar.gz
	cp ../Packages/fuse-3.17.4.tar.gz /sources

	echoL "Unpack Fuse (3.17.4)..."
	sleep 2
	cd /sources
	rm -fR fuse-3.17.4
	tar -vxsf fuse-3.17.4.tar.gz
	cd fuse-3.17.4

	echoL "Building Fuse (3.17.4)..."
	sleep 2
	sed -i '/^udev/,$ s/^/#/' util/meson.build &&
	mkdir build &&
	cd    build &&
	meson setup --prefix=/usr --buildtype=release .. &&
	ninja

	echoL "Installing Fuse (3.17.4)..."
	sleep 2
	ninja install
	chmod u+s /usr/bin/fusermount3
	cd ..
	cp -Rv doc/html -T /usr/share/doc/fuse-3.17.4
	install -v -m644   doc/{README.NFS,kernel.txt} /usr/share/doc/fuse-3.17.4

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR fuse-3.17.4

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
