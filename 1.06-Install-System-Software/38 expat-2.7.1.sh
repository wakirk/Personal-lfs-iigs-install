#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Expat (2.7.1) - 485 KB:
	# Home page: https://libexpat.github.io/
	# Download: https://github.com/libexpat/libexpat/releases/download/R_2_7_1/expat-2.7.1.tar.xz
	# MD5 sum: 9f0c266ff4b9720beae0c6bd53ae4469
	echoR "System Software"

	echoL "Downloading Expat (2.7.1)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://github.com/libexpat/libexpat/releases/download/R_2_7_1/expat-2.7.1.tar.xz expat-2.7.1.tar.xz
	cp ../Packages/expat-2.7.1.tar.xz /sources

	echoL "Unpack Expat (2.7.1)..."
	sleep 2
	cd /sources
	rm -fR expat-2.7.1
	tar -vxsf expat-2.7.1.tar.xz
	cd expat-2.7.1

	echoL "Building Expat (2.7.1)..."
	sleep 2
	./configure --prefix=/usr \
		--disable-static      \
		--docdir=/usr/share/doc/expat-2.7.1
	make

	echoL "Testing Expat (2.7.1)..."
	sleep 2
	make check

	echoL "Installing Expat (2.7.1)..."
	sleep 2
	make install
	install -v -m644 doc/*.{html,css} /usr/share/doc/expat-2.7.1

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR expat-2.7.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
