#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://github.com/shadow-maint/shadow/releases/download/4.18.0/shadow-4.18.0.tar.xz
	# Download MD5 sum: 30ef46f54363db1d624587be68794ef2
	# Download size: 2.2 MB
	# Estimated disk space required: 103 MB
	# Estimated build time: 0.2 SBU	
	echoR "Group 4 Security Layer"

	echoL "Downloading Shadow (4.18.0)..."
	sleep 2
	cd "/root/lfs/B-04-Security Layer"
	../bash/Download.sh https://github.com/shadow-maint/shadow/releases/download/4.18.0/shadow-4.18.0.tar.xz shadow-4.18.0.tar.xz
	cp ../Packages/shadow-4.18.0.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Shadow (4.18.0)..."
	sleep 2
	cd /sources
	rm -fR shadow-4.18.0
	tar -vxsf shadow-4.18.0.tar.xz
	cd shadow-4.18.0

	echoL "Building Shadow (4.18.0)..."
	sleep 2
	sed -i 's/groups$(EXEEXT) //' src/Makefile.in
	find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
	find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
	find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;
	sed -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD YESCRYPT@' \
		-e 's@/var/spool/mail@/var/mail@'                   \
		-e '/PATH=/{s@/sbin:@@;s@/bin:@@}'                  \
		-i etc/login.defs
	./configure --sysconfdir=/etc   \
				--disable-static    \
				--without-libbsd    \
				--with-{b,yes}crypt
	make

	echoL "Installing Shadow (4.18.0)..."
	sleep 2
	make exec_prefix=/usr pamddir= install
	make -C man install-man

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR shadow-4.18.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
