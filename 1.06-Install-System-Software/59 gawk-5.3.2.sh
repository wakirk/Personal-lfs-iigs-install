#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Gawk (5.3.2) - 3,662 KB:
	# Home page: https://www.gnu.org/software/gawk/
	# Download: https://ftp.gnu.org/gnu/gawk/gawk-5.3.2.tar.xz
	# MD5 sum: b7014650c5f45e5d4837c31209dc0037
	echoR "System Software"

	echoL "Downloading Gawk (5.3.2)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/gawk/gawk-5.3.2.tar.xz gawk-5.3.2.tar.xz
	cp ../Packages/gawk-5.3.2.tar.xz /sources

	echoL "Unpack Gawk (5.3.2)..."
	sleep 2
	cd /sources
	rm -fR gawk-5.3.2
	tar -vxsf gawk-5.3.2.tar.xz
	cd gawk-5.3.2

	echoL "Building Gawk (5.3.2)..."
	sleep 2
	sed -i 's/extras//' Makefile.in
	./configure --prefix=/usr
	make

	echoL "Testing Gawk (5.3.2)..."
	sleep 2
	chown -R tester .
	su tester -c "PATH=$PATH make check"

	echoL "Installing Gawk (5.3.2)..."
	sleep 2
	rm -f /usr/bin/gawk-5.3.2
	make install
	ln -sv gawk.1 /usr/share/man/man1/awk.1
	install -vDm644 doc/{awkforai.txt,*.{eps,pdf,jpg}} -t /usr/share/doc/gawk-5.3.2

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR gawk-5.3.2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
