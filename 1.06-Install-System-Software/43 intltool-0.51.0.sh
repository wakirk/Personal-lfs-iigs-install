#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Intltool (0.51.0) - 159 KB:
	# Home page: https://freedesktop.org/wiki/Software/intltool
	# Download: https://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz
	# MD5 sum: 12e517cac2b57a0121cda351570f1e63
	echoR "System Software"

	echoL "Downloading Intltool (0.51.0)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz intltool-0.51.0.tar.gz
	cp ../Packages/intltool-0.51.0.tar.gz /sources

	echoL "Unpack Intltool (0.51.0)..."
	sleep 2
	cd /sources
	rm -fR intltool-0.51.0
	tar -vxsf intltool-0.51.0.tar.gz
	cd intltool-0.51.0

	echoL "Building Intltool (0.51.0)..."
	sleep 2
	sed -i 's:\\\${:\\\$\\{:' intltool-update.in
	./configure --prefix=/usr
	make

	echoL "Testing Intltool (0.51.0)..."
	sleep 2
	make check

	echoL "Installing Intltool (0.51.0)..."
	sleep 2
	make install
	install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.51.0/I18N-HOWTO

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR intltool-0.51.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
