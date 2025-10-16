#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Tcl (8.6.16) - 11,406 KB:
	# Home page: https://tcl.sourceforge.net/
	# Download: https://downloads.sourceforge.net/tcl/tcl8.6.16-src.tar.gz
	# MD5 sum: eaef5d0a27239fb840f04af8ec608242
	echoR "System Software"

	echoL "Downloading Tcl (8.6.16)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://downloads.sourceforge.net/tcl/tcl8.6.16-src.tar.gz tcl8.6.16-src.tar.gz
	cp ../Packages/tcl8.6.16-src.tar.gz /sources

	../bash/Download.sh https://downloads.sourceforge.net/tcl/tcl8.6.16-html.tar.gz tcl8.6.16-html.tar.gz
	cp ../Packages/tcl8.6.16-html.tar.gz /sources


	echoL "Unpack Tcl (8.6.16)..."
	sleep 2
	cd /sources
	rm -fR tcl8.6.16
	tar -vxsf tcl8.6.16-src.tar.gz
	cd tcl8.6.16

	echoL "Building Tcl (8.6.16)..."
	sleep 2
	SRCDIR=$(pwd)
	cd unix
	./configure --prefix=/usr   \
		--mandir=/usr/share/man \
		--disable-rpath

	make
	sed -e "s|$SRCDIR/unix|/usr/lib|" \
		-e "s|$SRCDIR|/usr/include|"  \
		-i tclConfig.sh
	sed -e "s|$SRCDIR/unix/pkgs/tdbc1.1.10|/usr/lib/tdbc1.1.10|" \
		-e "s|$SRCDIR/pkgs/tdbc1.1.10/generic|/usr/include|"     \
		-e "s|$SRCDIR/pkgs/tdbc1.1.10/library|/usr/lib/tcl8.6|"  \
		-e "s|$SRCDIR/pkgs/tdbc1.1.10|/usr/include|"             \
		-i pkgs/tdbc1.1.10/tdbcConfig.sh
	sed -e "s|$SRCDIR/unix/pkgs/itcl4.3.2|/usr/lib/itcl4.3.2|" \
		-e "s|$SRCDIR/pkgs/itcl4.3.2/generic|/usr/include|"    \
		-e "s|$SRCDIR/pkgs/itcl4.3.2|/usr/include|"            \
		-i pkgs/itcl4.3.2/itclConfig.sh
	unset SRCDIR

	# echoL "Testing Tcl (8.6.16)..."
	# make test

	echoL "Installing Tcl (8.6.16)..."
	sleep 2
	make install 
	chmod 644 /usr/lib/libtclstub8.6.a
	chmod -v u+w /usr/lib/libtcl8.6.so
	make install-private-headers
	ln -sfv tclsh8.6 /usr/bin/tclsh
	mv /usr/share/man/man3/{Thread,Tcl_Thread}.3

	cd ..
	tar -vxf ../tcl8.6.16-html.tar.gz --strip-components=1
	mkdir -v -p /usr/share/doc/tcl-8.6.16
	cp -v -r  ./html/* /usr/share/doc/tcl-8.6.16

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR tcl8.6.16

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
