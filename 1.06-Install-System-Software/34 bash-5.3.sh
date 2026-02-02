#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Bash (5.3) - 11,089 KB:
	# Home page: https://www.gnu.org/software/bash/
	# Download: https://ftp.gnu.org/gnu/bash/bash-5.3.tar.gz
	# MD5 sum: 977c8c0c5ae6309191e7768e28ebc951
	echoR "System Software"

	echoL "Downloading Bash (5.3)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/bash/bash-5.3.tar.gz bash-5.3.tar.gz
	cp ../Packages/bash-5.3.tar.gz /sources

	echoL "Unpack Bash (5.3)..."
	sleep 2
	cd /sources
	rm -fR bash-5.3
	tar -vxsf bash-5.3.tar.gz
	cd bash-5.3

	echoL "Building Bash (5.3)..."
	sleep 2
	./configure --prefix=/usr     \
		--without-bash-malloc     \
		--with-installed-readline \
		--docdir=/usr/share/doc/bash-5.3
	make

	echoL "Installing Bash (5.3)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR bash-5.3

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
