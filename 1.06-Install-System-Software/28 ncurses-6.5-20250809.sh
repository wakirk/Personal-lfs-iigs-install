#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Ncurses (6.5-20250809) - 3,703 KB:
	# Home page: https://www.gnu.org/software/ncurses/
	# Download: https://invisible-mirror.net/archives/ncurses/current/ncurses-6.5-20250809.tgz
	# MD5 sum: 679987405412f970561cc85e1e6428a2
	echoR "System Software"
	echoL "Downloading Ncurses (6.5-20250809)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://invisible-mirror.net/archives/ncurses/current/ncurses-6.5-20250809.tgz ncurses-6.5-20250809.tgz
	cp ../Packages/ncurses-6.5-20250809.tgz /sources

	echoL "Unpack Ncurses (6.5-20250809)..."
	sleep 2

	cd /sources
	rm -fR ncurses-6.5-20250809
	tar -vxsf ncurses-6.5-20250809.tgz
	cd ncurses-6.5-20250809

	echoL "Building Ncurses (6.5-20250809)..."
	sleep 2

	./configure --prefix=/usr   \
		--mandir=/usr/share/man \
		--with-shared           \
		--without-debug         \
		--without-normal        \
		--with-cxx-shared       \
		--enable-pc-files       \
		--with-pkg-config-libdir=/usr/lib/pkgconfig
	make

	echoL "Installing Ncurses (6.5-20250809)..."
	sleep 2

	make DESTDIR=$PWD/dest install
	install -vm755 dest/usr/lib/libncursesw.so.6.5 /usr/lib
	rm -v  dest/usr/lib/libncursesw.so.6.5
	sed -e 's/^#if.*XOPEN.*$/#if 1/' -i dest/usr/include/curses.h
	cp -av dest/* /
	for lib in ncurses form panel menu ; do
		ln -sfv lib${lib}w.so /usr/lib/lib${lib}.so
		ln -sfv ${lib}w.pc    /usr/lib/pkgconfig/${lib}.pc
	done
	ln -sfv libncursesw.so /usr/lib/libcurses.so
	cp -v -R doc -T /usr/share/doc/ncurses-6.5-20250809

	echoL "Cleaning up build area...."
	sleep 2

	cd /sources
	rm -fR ncurses-6.5-20250809

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
