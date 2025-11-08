#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# External Project: dmi decode
	# URL: https://download.savannah.gnu.org/releases/dmidecode/dmidecode-3.6.tar.xz
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading DMI Decode (3.6)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://download.savannah.gnu.org/releases/dmidecode/dmidecode-3.6.tar.xz dmidecode-3.6.tar.xz
	cp ../Packages/dmidecode-3.6.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack DMI Decode (3.6)..."
	sleep 2
	cd /sources
	rm -fR dmidecode-3.6
	tar -vxsf dmidecode-3.6.tar.xz
	cd dmidecode-3.6

	echoL "Building DMI Decode (3.6)..."
	sleep 2
	# change prefix form /usr/local to /usr 
	sed -i.bak -E 's/^([[:space:]]*prefix[[:space:]]*=[[:space:]]*)\/usr\/local/\1\/usr/' Makefile
	make
	read

	echoL "Installing DMI Decode (3.6)..."
	sleep 2
	make install
	read

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR dmidecode-3.6

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
