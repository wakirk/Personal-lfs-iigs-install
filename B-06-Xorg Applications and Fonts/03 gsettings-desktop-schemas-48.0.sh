#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

# Required
# GLib-2.84.4 (with GObject Introspection)

main () {

	# Download (HTTP): https://download.gnome.org/sources/gsettings-desktop-schemas/48/gsettings-desktop-schemas-48.0.tar.xz
	# Download MD5 sum: e5721d5c378cb5fb4817943357b96ea5
	# Download size: 796 KB
	# Estimated disk space required: 21 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 6 Xorg Applications and Fonts"

	echoL "Downloading Desktop Schemas (48.0)..."
	sleep 2
	cd "/root/lfs/B-06-Xorg Applications and Fonts"
	../bash/Download.sh https://download.gnome.org/sources/gsettings-desktop-schemas/48/gsettings-desktop-schemas-48.0.tar.xz gsettings-desktop-schemas-48.0.tar.xz
	cp ../Packages/gsettings-desktop-schemas-48.0.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Desktop Schemas (48.0)..."
	sleep 2
	cd /sources
	rm -fR gsettings-desktop-schemas-48.0
	tar -vxsf gsettings-desktop-schemas-48.0.tar.xz
	cd gsettings-desktop-schemas-48.0

	echoL "Building Desktop Schemas (48.0)..."
	sleep 2
	sed -i -r 's:"(/system):"/org/gnome\1:g' schemas/*.in
	mkdir build
	cd    build
	meson setup --prefix=/usr --buildtype=release ..
	ninja

	echoL "Installing Desktop Schemas (48.0)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR gsettings-desktop-schemas-48.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
