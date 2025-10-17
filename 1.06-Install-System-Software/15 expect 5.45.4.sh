#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Expect (5.45.4) - 618 KB:
	# Home page: https://core.tcl.tk/expect/
	# Download: https://prdownloads.sourceforge.net/expect/expect5.45.4.tar.gz
	# MD5 sum: 00fce8de158422f5ccd2666512329bd2

	# Expect GCC15 Patch - 12 KB:
	# Download: https://www.linuxfromscratch.org/patches/lfs/12.4/expect-5.45.4-gcc15-1.patch
	# MD5 sum: 0ca4d6bb8d572fbcdb13cb36cd34833e
	echoR "System Software"

	echoL "Downloading Expect (5.45.4)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://prdownloads.sourceforge.net/expect/expect5.45.4.tar.gz expect5.45.4.tar.gz
	cp ../Packages/expect5.45.4.tar.gz /sources

	../bash/Download.sh https://www.linuxfromscratch.org/patches/lfs/12.4/expect-5.45.4-gcc15-1.patch expect-5.45.4-gcc15-1.patch
	cp ../Packages/expect-5.45.4-gcc15-1.patch /sources

	echoL "Unpack Expect (5.45.4)..."
	sleep 2
	cd /sources
	rm -fR expect5.45.4
	tar -vxsf expect5.45.4.tar.gz
	cd expect5.45.4

	echoL "Building Expect (5.45.4)..."
	sleep 2
	python3 -c 'from pty import spawn; spawn(["echo", "ok"])'
	patch -Np1 -i ../expect-5.45.4-gcc15-1.patch
	./configure --prefix=/usr   \
		--with-tcl=/usr/lib     \
		--enable-shared         \
		--disable-rpath         \
		--mandir=/usr/share/man \
		--with-tclinclude=/usr/include
	make
	echoL "Testing Expect (5.45.4)..."
	make test

	echoL "Expect (5.45.4)..."
	sleep 2
	make install
	ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR expect5.45.4

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
