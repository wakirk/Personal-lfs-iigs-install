#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://github.com/elogind/elogind/archive/v255.17/elogind-255.17.tar.gz
	# Download MD5 sum: 3cd76e1a71e13c4810f6e80e176a8fa7
	# Download size: 2.1 MB
	# Estimated disk space required: 59 MB (with tests)
	# Estimated build time: 0.2 SBU (with parallelism=4; with tests)
	echoR "Group 6 Xorg Applications and Fonts"

	echoL "Downloading elogind (255.17)..."
	sleep 2
	cd "/root/lfs/B-06-Xorg Applications and Fonts"
	../bash/Download.sh https://github.com/elogind/elogind/archive/v255.17/elogind-255.17.tar.gz elogind-255.17.tar.gz
	cp ../Packages/elogind-255.17.tar.gz /sources

	echoL "Unpack elogind (255.17)..."
	sleep 2
	cd /sources
	rm -fR elogind-255.17
	tar -vxsf elogind-255.17.tar.gz
	cd elogind-255.17

	echoL "Building elogind (255.17)..."
	sleep 2
	mkdir build
	cd    build
	meson setup ..                          \
	--prefix=/usr                           \
	--buildtype=release                     \
	-D man=auto                             \
	-D docdir=/usr/share/doc/elogind-255.17 \
	-D cgroup-controller=elogind            \
	-D dev-kvm-mode=0660                    \
	-D dbuspolicydir=/etc/dbus-1/system.d
	ninja

	echoL "Installing elogind (255.17)..."
	sleep 2
	ninja install
	ln -sfv  libelogind.pc /usr/lib/pkgconfig/libsystemd.pc
	ln -sfvn elogind /usr/include/systemd

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR elogind-255.17

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
