#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

 main () {

	echoR "System Software"

	echoL "Downloading Terminus fonts (4.49)..."
	sleep 2
	cd "/root/lfs/1.07-System-Config"
	../bash/Download.sh http://sourceforge.net/projects/terminus-font/files/terminus-font-4.49/terminus-font-4.49.1.tar.gz terminus-font-4.49.1.tar.gz
	cp ../Packages/terminus-font-4.49.1.tar.gz /sources

	echoL "Unpack Terminus fonts (4.49)..."
	sleep 2
	cd /sources
	rm -fR terminus-font-4.49.1
	tar -vxsf terminus-font-4.49.1.tar.gz
	cd terminus-font-4.49.1

	echoL "Building Terminus fonts (4.49)..."
	sleep 2
    make psf

	echoL "Installing Terminus fonts (4.49)..."
	sleep 2
    install -v -m644 *.psf /usr/share/consolefonts

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR terminus-font-4.49.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
