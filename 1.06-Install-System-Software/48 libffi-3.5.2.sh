#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Libffi (3.5.2) - 1,390 KB:
	# Home page: https://sourceware.org/libffi/
	# Download: https://github.com/libffi/libffi/releases/download/v3.5.2/libffi-3.5.2.tar.gz
	# MD5 sum: 92af9efad4ba398995abf44835c5d9e9
	echoR "System Software"

	echoL "Downloading Libffi (3.5.2)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://github.com/libffi/libffi/releases/download/v3.5.2/libffi-3.5.2.tar.gz libffi-3.5.2.tar.gz
	cp ../Packages/libffi-3.5.2.tar.gz /sources

	echoL "Unpack Libffi (3.5.2)..."
	sleep 2
	cd /sources
	rm -fR libffi-3.5.2
	tar -vxsf libffi-3.5.2.tar.gz
	cd libffi-3.5.2

	echoL "Building Libffi (3.5.2)..."
	sleep 2
	# [Note] Note
	# Like GMP, Libffi builds with optimizations specific to the processor in use. If building for another system,
	# change the value of the --with-gcc-arch= parameter in the following command to an architecture name
	# fully implemented by both the host CPU and the CPU on that system. If this is not done, all applications
	# that link to libffi will trigger Illegal Operation Errors. If you cannot figure out a value safe for
	# both the CPUs, replace the parameter with --without-gcc-arch to produce a generic library.
	./configure --prefix=/usr \
		--disable-static      \
		--with-gcc-arch=native
	make


	echoL "Testing Libffi (3.5.2)..."
	sleep 2
	make check

	echoL "Installing Libffi (3.5.2)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libffi-3.5.2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
