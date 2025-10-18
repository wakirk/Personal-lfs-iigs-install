#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Elfutils (0.193) - 11,695 KB:
	# Home page: https://sourceware.org/elfutils/
	# Download: https://sourceware.org/ftp/elfutils/0.193/elfutils-0.193.tar.bz2
	# MD5 sum: ceefa052ded950a4c523688799193a44
	# Libelf from Elfutils (0.193)
	echoR "System Software"

	echoL "Downloading Libelf from Elfutils (0.193)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://sourceware.org/ftp/elfutils/0.193/elfutils-0.193.tar.bz2 elfutils-0.193.tar.bz2
	cp ../Packages/elfutils-0.193.tar.bz2 /sources

	echoL "Unpack Libelf from Elfutils (0.193)..."
	sleep 2
	cd /sources
	rm -fR elfutils-0.193
	tar -vxsf elfutils-0.193.tar.bz2
	cd elfutils-0.193

	echoL "Building Libelf from Elfutils (0.193)..."
	sleep 2
	./configure --prefix=/usr \
		--disable-debuginfod  \
		--enable-libdebuginfod=dummy
	make

	echoL "Testing Libelf from Elfutils (0.193)..."
	sleep 2
	make check
	echo "Two tests are known to fail, dwarf_srclang_check and run-backtrace-native-core.sh."

	echoL "Installing Libelf from Elfutils (0.193)..."
	sleep 2
	make -C libelf install
	install -vm644 config/libelf.pc /usr/lib/pkgconfig
	rm /usr/lib/libelf.a

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR elfutils-0.193

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
