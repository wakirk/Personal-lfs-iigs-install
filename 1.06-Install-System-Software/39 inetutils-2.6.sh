#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Inetutils (2.6) - 1,724 KB:
	# Home page: https://www.gnu.org/software/inetutils/
	# Download: https://ftp.gnu.org/gnu/inetutils/inetutils-2.6.tar.xz
	# MD5 sum: 401d7d07682a193960bcdecafd03de94
	echoR "System Software"

	echoL "Downloading Inetutils (2.6)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/inetutils/inetutils-2.6.tar.xz inetutils-2.6.tar.xz
	cp ../Packages/inetutils-2.6.tar.xz /sources

	echoL "Unpack Inetutils (2.6)..."
	sleep 2
	cd /sources
	rm -fR inetutils-2.6
	tar -vxsf inetutils-2.6.tar.xz
	cd inetutils-2.6

	echoL "Building Inetutils (2.6)..."
	sleep 2
	sed -i 's/def HAVE_TERMCAP_TGETENT/ 1/' telnet/telnet.c
	./configure --prefix=/usr \
		--bindir=/usr/bin     \
		--localstatedir=/var  \
		--disable-logger      \
		--disable-whois       \
		--disable-rcp         \
		--disable-rexec       \
		--disable-rlogin      \
		--disable-rsh         \
		--disable-servers
	make

	echoL "Testing Inetutils (2.6)..."
	sleep 2
	make check
	echo "One test is known to fail, it's good."

	echoL "Installing Inetutils (2.6)..."
	sleep 2
	make install
	mv -v /usr/{,s}bin/ifconfig

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR inetutils-2.6

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
