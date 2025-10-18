#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Kmod (34.2) - 434 KB:
	# Home page: https://github.com/kmod-project/kmod
	# Download: https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-34.2.tar.xz
	# MD5 sum: 36f2cc483745e81ede3406fa55e1065a
	echoR "System Software"

	echoL "Downloading Kmod (34.2)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-34.2.tar.xz kmod-34.2.tar.xz
	cp ../Packages/kmod-34.2.tar.xz /sources

	echoL "Unpack Kmod (34.2)..."
	sleep 2
	cd /sources
	rm -fR kmod-34.2
	tar -vxsf kmod-34.2.tar.xz
	cd kmod-34.2

	echoL "Building Kmod (34.2)..."
	sleep 2
	mkdir -p build
	cd       build
	meson setup --prefix=/usr ..  \
		--buildtype=release       \
		-D manpages=false
	ninja

	echoL "Installing Kmod (34.2)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR kmod-34.2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
