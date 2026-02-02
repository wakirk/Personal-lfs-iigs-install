#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Texinfo (7.2) - 6,259 KB:
	# Home page: https://www.gnu.org/software/texinfo/
	# Download: https://ftp.gnu.org/gnu/texinfo/texinfo-7.2.tar.xz
	# MD5 sum: 11939a7624572814912a18e76c8d8972
	echoR "System Software"

	echoL "Downloading Texinfo (7.2)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/texinfo/texinfo-7.2.tar.xz texinfo-7.2.tar.xz
	cp ../Packages/texinfo-7.2.tar.xz /sources

	echoL "Unpack Texinfo (7.2)..."
	sleep 2
	cd /sources
	rm -fR texinfo-7.2
	tar -vxsf texinfo-7.2.tar.xz
	cd texinfo-7.2

	echoL "Building Texinfo (7.2)..."
	sleep 2
	sed 's/! $output_file eq/$output_file ne/' -i tp/Texinfo/Convert/*.pm
	./configure --prefix=/usr
	make

	echoL "Testing Texinfo (7.2)..."
	sleep 2
	make check

	echoL "Installing Texinfo (7.2)..."
	sleep 2
	make install
	make TEXMF=/usr/share/texmf install-tex
	pushd /usr/share/info
	rm -v dir
	for f in *
		do install-info $f dir 2>/dev/null
	done
	popd

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR texinfo-7.2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
