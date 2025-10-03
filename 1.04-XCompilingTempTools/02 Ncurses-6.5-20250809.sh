#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Ncurses (6.5-20250809) - 3,703 KB:
#Home page: https://www.gnu.org/software/ncurses/
#Download: https://invisible-mirror.net/archives/ncurses/current/ncurses-6.5-20250809.tgz
#MD5 sum: 679987405412f970561cc85e1e6428a2

main () {
	clear
	echoR "Installing Software"
	echoL "Downloading Ncurses 6.5-20250809..."

	echo "Downloading Ncurses 6.5-20250809... "
	../bash/Download.sh https://invisible-mirror.net/archives/ncurses/current/ncurses-6.5-20250809.tgz ncurses-6.5-20250809.tgz
	cp ../Packages/ncurses-6.5-20250809.tgz $LFS/sources
	cd $LFS/sources
	ls

	echoL "Unpack: Ncurses 6.5-20250809..."
	sleep 2
	rm -fR ncurses-6.5-20250809
	tar -vxsf ncurses-6.5-20250809.tgz
	cd ncurses-6.5-20250809
	mkdir build
	cd build

	echoL "Building Ncurses 6.5-20250809..."
	../configure --prefix=$LFS/tools AWK=gawk
	make -C include
	make -C progs tic
	install progs/tic $LFS/tools/bin
	cd ..
	./configure --prefix=/usr                \
		--host=$LFS_TGT              \
		--build=$(./config.guess)    \
		--mandir=/usr/share/man      \
		--with-manpage-format=normal \
		--with-shared                \
		--without-normal             \
		--with-cxx-shared            \
		--without-debug              \
		--without-ada                \
		--disable-stripping          \
		AWK=gawk
	make

	echoL "Installing Ncurses 6.5-20250809..."
	make DESTDIR=$LFS install
	ln -sv libncursesw.so $LFS/usr/lib/libncurses.so
	sed -e 's/^#if.*XOPEN.*$/#if 1/' -i $LFS/usr/include/curses.h

	echoL "Install Complete "
	sleep 2
	cd ..
	rm -fR ncurses-6.5-20250809
	
	exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
