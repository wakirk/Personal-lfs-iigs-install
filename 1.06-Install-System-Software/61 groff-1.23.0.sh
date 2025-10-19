#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Groff (1.23.0) - 7,259 KB:
	# Home page: https://www.gnu.org/software/groff/
	# Download: https://ftp.gnu.org/gnu/groff/groff-1.23.0.tar.gz
	# MD5 sum: 5e4f40315a22bb8a158748e7d5094c7d
	echoR "System Software"

	echoL "Downloading Groff (1.23.0)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/groff/groff-1.23.0.tar.gz groff-1.23.0.tar.gz
	cp ../Packages/groff-1.23.0.tar.gz /sources

	echoL "Unpack Groff (1.23.0)..."
	sleep 2
	cd /sources
	rm -fR groff-1.23.0
	tar -vxsf groff-1.23.0.tar.gz
	cd groff-1.23.0

	echoL "Building Groff (1.23.0)..."
	sleep 2
	PAGE=letter ./configure --prefix=/usr
	make

	echoL "Testing Groff (1.23.0)..."
	sleep 2
	make check
	/bin/bash

	echoL "Installing Groff (1.23.0)..."
	sleep 2
	make install
	echo "letter" > /etc/papersize

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR groff-1.23.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
