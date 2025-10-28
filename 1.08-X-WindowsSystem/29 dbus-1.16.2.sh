#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://dbus.freedesktop.org/releases/dbus/dbus-1.16.2.tar.xz
	# Download MD5 sum: 97832e6f0a260936d28536e5349c22e5
	# Download size: 1.1 MB
	# Estimated disk space required: 25 MB (add 6 MB for tests)
	# Estimated build time: 0.3 SBU (add 0.4 SBU for tests)
	echoR "System Software"

	echoL "Downloading dbus (1.16.2)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://dbus.freedesktop.org/releases/dbus/dbus-1.16.2.tar.xz dbus-1.16.2.tar.xz
	cp ../Packages/dbus-1.16.2.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack dbus (1.16.2)..."
	sleep 2
	cd /sources
	rm -fR dbus-1.16.2
	tar -vxsf dbus-1.16.2.tar.xz
	cd dbus-1.16.2

	echoL "Building dbus (1.16.2)..."
	sleep 2
	mkdir build
	cd    build
	meson setup --prefix=/usr \
	--buildtype=release       \
	--wrap-mode=nofallback    \
	-D systemd=disabled ..
	ninja

	echoL "Installing dbus (1.16.2)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR dbus-1.16.2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
