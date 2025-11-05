#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Sudo Dependencies
	# Optional
	#	Linux-PAM-1.7.1
	#	MIT Kerberos V5-1.22.1
	#	OpenLDAP-2.6.10
	#	MTA (that provides a sendmail command),
	#	AFS
	#	libaudit
	#	Opie
	#	Sssd

main () {

	# Download (HTTP): https://www.sudo.ws/dist/sudo-1.9.17p2.tar.gz
	# Download MD5 sum: dcbf46f739ae06b076e1a11cbb271a10
	# Download size: 5.2 MB
	# Estimated disk space required: 54 MB (add 10 MB for tests)
	# Estimated build time: 0.2 SBU (with parallelism=4; add 0.1 SBU for tests)
	echoR "Group 4 Security Layer"

	echoL "Downloading Sudo (1.9.17p2)..."
	sleep 2
	cd "/root/lfs/B-04-Security Layer"
	../bash/Download.sh https://www.sudo.ws/dist/sudo-1.9.17p2.tar.gz sudo-1.9.17p2.tar.gz
	cp ../Packages/sudo-1.9.17p2.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Sudo (1.9.17p2)..."
	sleep 2
	cd /sources
	rm -fR sudo-1.9.17p2
	tar -vxsf sudo-1.9.17p2.tar.gz
	cd sudo-1.9.17p2

	echoL "Building Sudo (1.9.17p2)..."
	sleep 2
	./configure --prefix=/usr \
		--libexecdir=/usr/lib \
		--with-secure-path    \
		--with-env-editor     \
		--docdir=/usr/share/doc/sudo-1.9.17p2 \
		--with-passprompt="[sudo] password for %p: " &&
	make

	echoL "Testing Sudo (1.9.17p2)..."
	sleep 2
	env LC_ALL=C make check 		# |& tee make-check.log

	echoL "Installing Sudo (1.9.17p2)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR sudo-1.9.17p2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
